# Comportamiento Actual Y Limitaciones Conocidas

## Proposito

Este documento describe **lo que hace el codigo en `main`**, no lo que se
espera que haga el protocolo ni una propuesta de rediseño. Es una auditoria
de lectura de codigo hecha el 15-jul-2026 sobre el commit `ba18d11`.

No cambia ningun comportamiento. Su objetivo es que una persona pueda decidir
si esta version sirve para su sesion, que excepciones debe vigilar y que debe
revisar un futuro desarrollador.

Etiquetas usadas:

- **[CODIGO]** confirmado al leer los modulos indicados.
- **[LAB]** requiere o tiene evidencia de una prueba fisica; no se infiere solo
  del codigo.
- **[NO RESUELTO]** limitacion conocida que permanece intencionalmente en esta
  version.

> Los documentos que hablan de un CSV principal de 10 columnas o de
> `ensayo_cruce` describen una rama experimental retirada. No describen el
> runtime actual. Vease tambien la [decision de restauracion](decisions/2026-07-15-restauracion-base-valentiae.md).

## Mapa Corto Del Runtime

`abrir` llama `abrir1`, que muestra cinco opciones:

| Opcion del menu | Modulo principal | Alcance de esta auditoria |
|---|---|---|
| Moldeamiento / palanqueo | `OA_ValentiaEntrenaPalancasCP` | Revision de riesgos generales. |
| Luz-comida | `OA_ValentiaEntrenaPalancasCPE` | Revision de riesgos generales. |
| ValentiaE | `OA_ValentiaCuatroE` | Revision detallada: seguros, discriminacion y sonido solo. |
| ValentiaE2 | `OA_ValentiaCuatroE2` | Revision detallada: cruces peligrosos. |
| Condicionamiento aleatorio | `OA_Condiciona_Aleatorio` | Revision de riesgos generales. |

Los cinco programas comparten estas dependencias fragiles:

- `OA_ValentiaInicio`: tarjeta NI antigua, fijada a `Dev2`.
- `OA_PreparaSonidos` y `OA_Sonidos`: audio `winsound`, dos canales y 20 kHz.
- `OA_ValentiaBuscaIzquierda` / `OA_ValentiaBuscaDerecha`: deteccion de llegada.
- `OA_ValentiaRevisaPalanca`: contador fisico de cuatro bits por lado.
- `ControlTarea.mat` y otros `.mat` de estado en `matlab/Valentia/`.

**No abrir dos programas de la caja al mismo tiempo.** Comparten la misma
tarjeta y archivos de control; una instancia puede interferir con la otra.

## Lo Mas Importante Para Operar

| Situacion | Que ocurre hoy | Accion operativa |
|---|---|---|
| ValentiaE: la rata llega al lado objetivo pero no palanquea | El ensayo puede quedar esperando sin limite. | Usar **Detener ahora**. `Detener tras ensayo` no puede terminar un ensayo que aun espera palanca. |
| ValentiaE2/CP: la rata cruza pero no palanquea | Igual: el ensayo queda esperando sin limite. | Usar **Detener ahora** y anotar la excepcion. |
| ValentiaE2/CP: se pulsa detener durante ITI | El codigo puede tardar hasta el final del ITI (60 a 180 s) en leer el boton. | Esperar; no asumir que el boton fallo inmediatamente. |
| ValentiaE: contador `Ensayos terminados` | Cuenta cada fila registrada, incluidos no-cruces y sonido solo. No cuenta solo cruces reales. | No usarlo como contador de cruces validos. |
| Evento `sonido solo` | No es solo audio: activa ruido, LED marcador y `OA_ValentiaElectrico(1)`; no activa luz de comida ni pellet. | Confirmar que esto coincide con la condicion experimental antes de usarlo. |
| Moldeamiento o Luz-comida: boton dedicado de detener lado derecho | Escribe un archivo de control distinto del que consulta el ciclo derecho. | **[NO RESUELTO]** No confiar en ese boton sin una prueba breve previa. |

## ValentiaE: Discriminacion Y Cruces Seguros

### Secuencia

**[CODIGO]** `OA_SecuenciaDiscriminacionSonidoSolo` recibe riesgo, maximo de
repeticiones por lado y la casilla de sonido solo.

- Riesgo `0`: genera 1000 eventos seguros y no agrega sonido solo.
- Riesgo mayor que `0` con sonido solo apagado: usa la secuencia legacy de
  1000 eventos. El numero escrito por el usuario controla el corte, no la
  longitud generada.
- Riesgo mayor que `0` con sonido solo activado: el numero debe ser multiplo de
  10. Por cada 10 eventos con comida agrega uno de tipo `2` (sonido solo), por
  lo que pedir 10 genera 11 filas potenciales.
- El primer evento de la sesion se fuerza a seguro. Los eventos de riesgo y de
  sonido solo fuerzan cambio de lado. Los seguros pueden repetir lado, hasta el
  maximo configurado.
- La casilla visible `Secuencia aleatoria` es informativa: el codigo no lee su
  valor. La secuencia sigue usando aleatorizacion aunque se desmarque.

### Que Significa Un Evento Del Mismo Lado

**[CODIGO]** El programa reconoce un mismo lado comparando el lado programado
contra el del evento anterior. No tiene un temporizador especial para ese
caso: usa la duracion maxima normal de seguro o riesgo.

El detalle decisivo es el orden interno:

1. Se enciende el estimulo y se espera detectar el lado objetivo.
2. **Solo en esta espera** se aplica `DurMaxEns`.
3. Al detectarse el lado objetivo, el codigo entra a otro ciclo que espera la
   palanca requerida sin revisar `DurMaxEns`.

En un mismo lado la rata suele estar ya frente al sensor objetivo; por eso el
paso 1 puede terminar casi de inmediato y el programa pasa a la espera de
palanca sin limite. No es que el maximo del mismo lado este configurado mal:
**no existe un maximo global de evento despues de detectar llegada.**

### Cruce, No Cruce Y Final De Sesion

- Si no se detecta el lado objetivo antes de `DurMaxEns`, se escribe una fila
  con `Lado=-2`, no hay pellet y el programa avanza.
- Si se detecta el lado y se alcanza el numero de palancas, se escribe la fila
  y se entrega el numero configurado de pellets.
- `cmc_es_cruce_valido` calcula una regla util para analisis (cambio de lado,
  zona inicial lateral y desplazamiento >= 1 s), pero su resultado solo se
  imprime en consola. **No decide el fin de la sesion.**
- El contador visible y el fin automatico usan `cmc_ensayos_terminados`, que
  equivale al numero de filas de `Resultados`. Por tanto incluyen no-cruces y
  sonido solo completos.

### Evento Tipo 2: Sonido Solo

**[CODIGO]** En `main` dura 180 s fijos. Durante ese tiempo registra la
primera llegada y palanqueos, pero una llegada o una palanca no lo terminan ni
producen recompensa. Activa ruido blanco, LED marcador y parrilla/estimulo
electrico; no enciende la luz de comida ni dispensa pellet. Si se usa
`Detener ahora` a mitad del evento, este no genera fila final.

### Cierre Y Guardado

ValentiaE si ejecuta habituacion inicial, tarea, habituacion final y dialogo
de guardado. El LED final es opcional y, en el codigo actual, parpadea 100 ms
cada **2 s** mientras el dialogo esta abierto. Al guardar o cancelar se apaga.

El guardado produce:

- un archivo `.mat` con `Resultados` y `EventosPalanqueo`;
- un CSV separado `nombre_palanqueos.csv`.

No existe actualmente un CSV principal de resultados.

## ValentiaE2: Cruces Peligrosos

### Flujo Actual

- Solo acepta riesgo `1` y fuerza una repeticion maxima por lado de `1`; en el
  uso normal los objetivos alternan. El codigo de mismo lado aun existe, pero
  no deberia alcanzarse bajo esa configuracion forzada.
- La habituacion se implementa como ciclos aproximados de 0.3 s calculados con
  `round(THabitua/0.42)`. No garantiza una duracion de pared exacta.
- Entre eventos normales hay un ITI bloqueante aleatorio de 60 a 180 s.
- Los eventos de sonido solo se intentan cerca de los minutos 9, 18 y 27 de
  conducta. La comprobacion ocurre despues de cada ITI, asi que pueden iniciar
  tarde. No hay una garantia de reloj duro de 30 min.
- El sonido solo de CP dura lo indicado por la maxima duracion de riesgo; no
  termina al cruzar o palanquear, no da pellet y usa LED marcador, ruido y
  estimulo electrico.

### Excepcion Conocida: Cruza Sin Palanquear

**[CODIGO] [NO RESUELTO]** En un evento normal de CP, `DurMaxEns` termina solo
la espera para detectar llegada. Despues de que la rata cruza, un `while(1)`
espera la palanca correcta sin limite temporal. Este es exactamente el caso
"cruzo pero no palanqueo": la luz/estimulo puede seguir activo hasta que haya
palanqueo o el operador use **Detener ahora**.

Esta conducta no es una correccion pendiente oculta; es una limitacion
conocida de la version actual. Cualquier futura correccion debe probarse por
separado y no asumirse como compatible sin evidencia fisica.

### Conteo, Fin Y Datos

- El contador de CP incrementa cuando detecta llegada en un cambio de lado,
  antes de confirmar palanca. No controla el fin de la sesion.
- El final usa el numero de eventos programados (`Ensayo`), no ese contador ni
  una regla de cruce valido.
- CP guarda un `Resultados` de 9 columnas en el estado interno y permite
  exportar manualmente un `.mat`. No tiene el guardado final automatico ni el
  CSV detallado de palanqueos de ValentiaE.
- El boton de detener se revisa dentro de la espera de palanca, pero durante el
  `pause` del ITI puede responder hasta 180 s despues.
- El valor inicial de pellets en riesgo es `2`. Si el protocolo requiere una
  presion = un pellet, el operador debe revisarlo antes de empezar.

## Otros Tres Programas Del Menu

### Condicionamiento Aleatorio

**[CODIGO]** Usa `pause` para habituacion, ITI y partes del estimulo. El boton
de detener se consulta al terminar cada ciclo, no durante un `pause`. Por eso
no es una parada inmediata. No genera la tabla estructurada de ValentiaE.

### Moldeamiento Y Luz-Comida

Ambos programas son control manual de palancas/recompensas, con contadores y
archivos `.mat` de estado heredados.

- Sus contadores se basan en cambios del contador fisico, no en un registro
  temporal completo por evento.
- En Moldeamiento y Luz-Comida, el control del ciclo derecho consulta
  `controlEnt`, pero su boton dedicado guarda `controlEntD`. Es una discrepancia
  de codigo que puede impedir que ese boton termine el ciclo derecho.
  **[NO RESUELTO]**
- Los guardados son agregados `.mat`; no equivalen al registro detallado de
  palanqueos implementado en ValentiaE.

Estas rutas no recibieron la misma validacion funcional reciente que
ValentiaE. Hacer una prueba breve con caja antes de una sesion real.

## Formato Real De `Resultados` En Main

La tabla actual tiene nueve columnas:

`Ens., Lado, Est., Lat., T. abs., Pal. I, Pal. D, Despl., Tipo`

- `Lado`: `1` izquierda, `0` derecha, `-2` si no se detecto el objetivo antes
  del maximo. En tipo 2 registra la primera llegada observada o `-2`.
- `Est.`: `0` seguro; `1` riesgo o sonido solo.
- `Lat.`: en ensayos con comida, tiempo hasta detectar lado objetivo; en
  sonido solo es la duracion completa del evento; en no-cruce equivale al
  maximo configurado.
- `Tipo`: `0` seguro, `1` riesgo con comida, `2` sonido solo.

En un ensayo normal con comida, una fila lateral (`Lado` 0 o 1) suele
escribirse al alcanzar el criterio de palanca; no hay columna explicita que
diga "palanqueo si/no". No debe inferirse una conducta desde una fila ausente,
porque un paro manual puede dejar un ensayo sin fila.

## Limitaciones De Sensores, Palancas Y Hardware

- La posicion usa 18 sensores. La clasificacion ignora los sensores 4 y 9
  porque permanecen activos sin rata/mano; una lectura simultanea o incompleta
  se marca como `ambigua`.
- Los contadores fisicos de palanca son de 4 bits (0 a 15). El CSV calcula la
  diferencia modulo 16. Si hubiera 16 o mas pulsaciones entre dos lecturas, el
  numero exacto seria ambiguo. **[CODIGO]** Es improbable en uso normal, pero
  es un limite real del dato crudo.
- La tarjeta esta fijada a `Dev2` y el audio a `winsound` con 20 kHz. Un cambio
  de equipo, drivers, orden de tarjetas o MATLAB puede impedir abrir la GUI.
- `OA_FinSonidos.m` contiene una copia antigua con nombre de funcion
  inconsistente. El flujo normal usa `stop(handles.GS)`, no ese archivo. No se
  debe "arreglar" como limpieza aislada sin una prueba de audio.

## Que Esta Probado Y Que No

- **[LAB]** La validacion historica de Discriminacion esta en
  `bitacora-lab-2026-07-12-valentiae.md`, pero varias reglas de esa bitacora
  pertenecen a la rama posterior retirada. No debe leerse como certificacion
  de las reglas actuales de conteo.
- **[CODIGO]** Existe una suite sin hardware, pero no puede simular tarjeta NI,
  lasers, palancas, audio real ni la ruta indefinida tras detectar llegada.
- **[PENDIENTE]** Antes de una sesion critica: prueba corta de cada programa
  usado, incluido detener, cierre, guardado y salida de cada estimulo.

## Regla Para Futuras Modificaciones

No alterar directamente `OA_ValentiaCuatroE.m` o `OA_ValentiaCuatroE2.m` para
"corregir" una excepcion observada. Primero documentar el caso, crear una rama
separada, escribir una prueba sin hardware y despues una prueba corta con la
caja. Este documento debe actualizarse en el mismo cambio que modifique una
limitacion conocida.
