# Cambios Reutilizables: Discriminacion A Cruces Peligrosos

Alcance: cambios aplicados en `OA_ValentiaCuatroE` (Discriminacion). Este
documento es la lista de transferencia para `OA_ValentiaCuatroE2` (Cruces
Peligrosos), no una afirmacion de que ya esten aplicados ahi.

## Cambios Ya Aplicados En Discriminacion

### Arranque Y Aislamiento

| Problema simple | Resolucion tecnica | Estado para CP |
|---|---|---|
| MATLAB podia abrir codigo viejo por accidente. | `abrir1`, el lanzador RC3 y `cmc_prepara_entorno_r2011a` restauran el path y cargan solo la copia portable del Escritorio. | Ya compartido por todo el programa. |
| Una falla era dificil de repetir o diagnosticar. | Se agregaron lanzadores y pruebas sin hardware para secuencia, audio, sonido solo y resultados. | Reutilizable sin cambio. |
| El ruido blanco podia iniciar en 5000 Hz. | `cmc_frecuencia_ruido_predeterminada` fija 15000 Hz para todos los modulos que ya la usan; se valido la separacion estereo fisicamente. | Ya compartido. |
| Abrir `ValentiaE` podia dispensar un pellet. | `OA_ValentiaInicio` ahora deja las lineas 17:23 en cero al arrancar; se eliminó una secuencia de salida equivalente a la recompensa izquierda. | Pendiente prueba fisica; aplicar a todo programa que abra esta tarjeta. |

### Conducta Y Eventos

| Problema simple | Resolucion tecnica | Estado para CP |
|---|---|---|
| Faltaba un evento de solo sonido. | Tipo `2`: ruido blanco, LED marcador y parrilla, sin luz de comida ni pellet. Dura 180 s completos aunque la rata cruce. | CP ya tiene la planificacion de tipo `2`; falta validar su flujo completo. |
| Sonido solo aparecia aun en cruces seguros. | En Discriminacion solo se agrega con riesgo mayor que cero y checkbox `Agregar evento sonido 1:10` activo. | No copiar literalmente: CP usa programacion por tiempo. |
| Riesgo y sonido solo no debian existir si la rata no cambia de lado. | La secuencia los coloca solo en cambios de lado; los repetidos siguen siendo seguros. | Regla comun que CP debe conservar. |
| El reloj se congelaba durante sonido solo al cruzar. | `OA_MonitoreaSonidoSolo` sigue los 180 s completos y actualiza el reloj visual. | Aplicar al monitor CP. |
| Detener podia perder datos o cortar un ensayo a medias. | `Detener ahora` termina sin inventar una fila; `Detener tras ensayo` cierra el evento actual. Los textos de ambos botones quedan estables. | Aplicar. |
| La habituacion final quedaba fuera de los datos. | La rutina final se ejecuta antes de guardar el estado temporal y el registro admite fase `habituacion_final`. | Falta el flujo automatico completo en ambos programas. |

### Datos, Tabla Y GUI

| Problema simple | Resolucion tecnica | Estado para CP |
|---|---|---|
| La tabla no distinguia los tres tipos de evento. | Columna 9 `Tipo`: 0 seguro, 1 riesgo, 2 sonido solo. El `.mat` conserva precision completa; la vista muestra 0.01 s. | Aplicar. |
| La columna 9 no cabia en R2011a. | Se compactaron encabezados y columnas; el rectangulo exterior ahora se ajusta al ancho real de las nueve columnas. | Pendiente inspeccion visual R2011a. |
| Habia demasiadas opciones que nadie usa. | Se ocultaron controles muertos: palancas, sonido inicial, luz intermitente, retardo y audio izquierdo/derecho. Valores utiles por defecto: luz segura; luz y sonido de riesgo; secuencia y sonido 1:10 activados. | Aplicar solo despues de revisar GUI CP. |
| `Secuencia Aleatoria` genera ansiedad si desaparece. | Se conserva visible y marcada, aunque el callback historico no cambia la secuencia. | Mantener por compatibilidad de uso. |
| Los palanqueos solo se veian como contadores incompletos y no se guardaban. | `EventosPalanqueo` registra segundo, fase, ensayo, tipo, lado y contador fisico. Al guardar se crea un `.mat` y un CSV hermano. | Aplicar despues de validar el contador fisico. |
| El contador de ensayos ignoraba los no-cruces. | **En rama `feature/sensor-validated-crosses`:** `Ensayos terminados` es el numero de filas en `Resultados`. Incluye cruce, repeticion, `-2` y sonido solo completo; no cuenta un ensayo abortado sin fila. | Validado en Discriminacion; pendiente transferencia a CP. |

## Registro De Palanqueos

Problema simple: los tres pares de contadores de la GUI no eran datos
confiables. `Sin luz` nunca se actualizaba; durante ensayo solo se leian
palancas despues del cruce; y un salto del contador fisico se contaba como un
solo cambio.

Resolucion tecnica actual:

- `cmc_registrar_palanqueos` interpreta los contadores de cuatro bits y
  registra cada incremento, incluso si pasa de 15 a 0.
- `EventosPalanqueo` se guarda dentro del `.mat` junto con `Resultados`.
- `nombre_palanqueos.csv` contiene las mismas filas con estas columnas:
  `evento_sesion`, `tiempo_s`, `fase`, `ensayo`, `tipo_evento`, `lado`,
  `contador_lado_sesion`, `contador_hardware`.
- `evento_sesion` es consecutivo para toda la sesion. `contador_lado_sesion`
  es consecutivo por lado. `contador_hardware` se conserva como valor crudo de
  la tarjeta: es independiente por lado, vuelve de 15 a 0 y puede resetearse.
- En habituacion y `sin_luz`, `ensayo` es `NA` en CSV y `NaN` en `.mat`; no es
  un inexistente "ensayo 0". Python puede leer `NA` directamente como faltante.
- Esta mejora de esquema vive en la rama hija
  `feature/lever-event-analysis-schema`. Pasó pruebas sin hardware; falta una
  sesion fisica que genere el nuevo CSV.
- Fases actuales: `habituacion_inicial`, `sin_luz`, `ensayo` y
  `habituacion_final`.

La prueba de sesion con rata genero el archivo correctamente y mostro saltos
rapidos del contador. La prueba fisica controlada posterior los aclaro: una
presion lenta por lado genero exactamente un incremento; tres presiones rapidas
generaron exactamente tres. No se observo rebote en esa prueba. Por tanto, los
saltos de la sesion probablemente fueron presiones reales repetidas mientras la
rata o el operador intentaban completar la deteccion corporal por los laseres.

Validacion ampliada en `pruebachecar.mat` (11-jul-2016): el `.mat` y su CSV
hermano contienen las mismas 48 palanqueadas. Cobertura por fase: 33 en
`habituacion_inicial`, 6 en `sin_luz` (ITI), 4 en `ensayo` y 5 en
`habituacion_final`. El contador derecho tambien cruzo de 15 a 0 sin perder
eventos. Esta sesion tuvo seguros y riesgos; no incluyo un evento `sonido_solo`.

## Cruces Validos: Rama De Sensores

La version estable RC3 conserva el contador historico. El cambio fundamental
vive aislado en la rama `feature/sensor-validated-crosses`.

Un cruce valido requiere las cuatro condiciones: cambio de lado programado,
inicio lateral confirmado por sensores, llegada al lado opuesto y
desplazamiento de al menos `1 s`. La ultima condicion iguala el criterio usado
en el analisis posterior.

Prueba fisica del 11-jul-2016 con mano extendida y sin retirar la mano de la
caja:

| Ensayo | Inicio detectado | Lado programado | Desplazamiento | Contador |
|---|---:|---:|---:|---|
| 1 | I | I | 7.036 s | valido |
| 2 | C | D | 3.714 s | rechazado por inicio en centro |
| 3 | I | I | 1.954 s | valido |

La prueba de software cubre el limite: `0.99 s` se rechaza y `1.00 s` se
acepta. En esta corrida, el intervalo interno entre el registro de una respuesta
y el inicio MATLAB del siguiente evento fue `6.75-6.79 s`; por ello una rata
puede legitimamente quedar en el centro entre ensayos. El programa viejo no
resolvia esa excepcion y podia inflar el contador. El video sigue siendo la
referencia para medir el ITI visual exacto.

## Pendientes Antes De Copiar A CP

| Pendiente | Criterio de terminado |
|---|---|
| Validar palanqueos con prueba fisica controlada. | **Completado:** 1 presion lenta produjo 1 incremento; 3 rapidas produjeron 3. |
| Definir ensayo valido para el contador de cruces. | **Completado y probado en rama `feature/sensor-validated-crosses`:** un cruce real exige cambio de lado programado, posicion inicial lateral confirmada, llegada al lado opuesto y desplazamiento de al menos 1 s. El umbral replica el analisis posterior. Un inicio desde el centro no infla el contador. |
| Contar no-cruces como ensayos terminados. | **Probado fisicamente en `prueba2044.mat`:** una fila con lado `-2` sumo como ensayo 1; una repeticion y un cruce lento completaron los ensayos 2 y 3. |
| Hacer que `Ensayos a realizar` use ensayos terminados segun la regla acordada. | **Completado y probado:** `prueba2044.mat` tuvo tres filas (`-2`, repeticion y cruce) y la secuencia cerró sola tras la tercera. |
| Cronometros de habituacion inicial y final. | La GUI muestra tiempo transcurrido y el tiempo configurado se cumple. |
| Finalizacion automatica. | **Implementada:** `Inicio` ejecuta habituacion inicial, ensayos y habituacion final; despues abre el dialogo de guardado en `C:\Users\Alberto\Documents` y guarda `.mat` y CSV juntos. Cancelar conserva el estado temporal para el boton manual. Falta prueba fisica de esta ruta, cronometros visibles y aviso LED opcional. |
| Validar CSV analizable en Python. | Ejecutar una sesion corta en `CajaValentia_R2011a_CrucesSensor` y confirmar columnas nuevas, `NA` fuera de ensayo, acumulados secuenciales y, si es posible, una palanqueada durante sonido solo. |
| Ajustar el rectangulo exterior de `uitable1`. | **Implementado en `fix/startup-and-table`:** el ancho exterior se calcula desde las nueve columnas. Falta inspeccion visual R2011a. |
| Centrar los valores de `uitable1`. | En GUIDE/R2011a no existe una propiedad estable para centrar celdas. Revisar visualmente; no introducir un hack Java o espacios variables sin necesidad real. |
| Transferir los cambios a `OA_ValentiaCuatroE2`. | Simulacion y prueba fisica CP completadas antes de uso experimental. |

## Regla De Trabajo

Cada pendiente se implementa primero en Discriminacion, se prueba sin hardware,
luego con la caja y solo entonces se adapta a Cruces Peligrosos. No copiar una
GUI completa sin revisar sus diferencias conductuales.

## Pruebas Modulares Para La Siguiente Visita Al Laboratorio

La interfaz y el hardware son antiguos; por eso no se debe probar toda la
sesion como una sola cosa. Cada modulo tiene una pregunta simple y un criterio
de exito. Si uno falla, se corrige ese modulo antes de continuar.

| Modulo | Que se prueba | Exito esperado | Estado actual |
|---|---|---|---|
| 1. Arranque seguro | Abrir `ValentiaE` sin rata. | No cae pellet, no se enciende luz, parrilla ni audio. | Cambio de codigo y prueba sin hardware listos; falta caja. |
| 2. Tabla | Abrir la GUI y guardar una corrida corta. | Nueve columnas visibles, sin traslape; MAT conserva la columna `Tipo`. | Logica lista; falta inspeccion visual R2011a. |
| 3. Conteo de ensayos | Simular cruce, mismo lado y no-cruce. | Cada fila valida cuenta una vez; un inicio en centro no infla el conteo. | Probado fisicamente en la rama de cruces por sensores. |
| 4. Sonido solo | Riesgo mayor que cero y casilla 1:10 activada. | Evento tipo 2 dura 180 s, sin comida ni pellet, y queda en MAT/CSV. | Prueba inicial funcional; falta validar CSV con una palanqueada real. |
| 5. Cierre y guardado | Detener ahora o tras ensayo. | Pasa por habituacion final y ofrece guardar MAT mas CSV juntos. | Flujo implementado; falta confirmar ruta Documents en R2011a. |
| 6. Palanqueos | Una presion lenta y varias rapidas en cada fase. | CSV ordenado, `NA` fuera de ensayo y contadores de sesion consecutivos. | Esquema probado sin hardware; falta validar el CSV nuevo. |
| 7. Aviso final | Casilla `Aviso LED al finalizar` activada al terminar. | LED marcador: 100 ms encendido cada 2 s hasta cerrar el dialogo de guardado. | Implementado y probado sin hardware; falta caja. |

El reloj de la GUI tambien funciona como cronometro de fase: durante
`habituacion_inicial` y `habituacion_final` muestra `transcurrido / total`.
Al comenzar los ensayos recupera su etiqueta y formato de reloj de ensayo.
Esta parte paso prueba sin hardware; falta inspeccion visual R2011a.

### Aviso LED Final

La casilla `Aviso LED al finalizar` aparece debajo de `Agregar evento sonido
1:10`, sin ocupar la tabla ni mover botones existentes. Por seguridad inicia
apagada. Si se marca, al terminar la habituacion final se abre el dialogo de
guardado y, mientras ese dialogo este abierto, el LED marcador de estimulacion
electrica enciende 100 ms al inicio de cada ciclo de 2 s.

El aviso no entrega pellet, no enciende las luces de comida y no inicia ruido
blanco. Se detiene y apaga el LED al guardar, cancelar o cerrar el dialogo.
La funcion legacy que controla el LED mantiene su pausa normal de 0.3 s para
todo el codigo existente; el aviso final es la unica llamada que solicita pausa
cero, porque necesita un pulso de 100 ms controlado por un `timer` de MATLAB.

### Pendientes Fisicos Antes De Uso Experimental

- Confirmar que el inicio seguro no entrega pellet al abrir la GUI.
- Revisar en R2011a que tabla, casilla de sonido, casilla LED y boton
  `Detener tras ensayo` no se traslapen.
- Probar el cronometro de ambas habituaciones y la ruta de guardado Documents.
- Con la casilla LED marcada, comprobar pulso visible de 100 ms cada 2 s y
  apagado inmediato al cerrar el dialogo.
- Generar una sesion corta para confirmar el CSV nuevo, incluyendo si es
  posible una palanqueada durante `sonido_solo`.

### Limite Conocido De La Tabla

`uitable` clasico de GUIDE/R2011a no ofrece una propiedad estable para centrar
el texto de las celdas. No se agregara un hack Java ni espacios manuales: ambos
pueden romperse entre R2011a y versiones modernas. El ancho, encabezados y la
precision de los valores si estan bajo control del codigo.
