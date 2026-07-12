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
| La columna 9 no cabia en R2011a. | Se compactaron encabezados y columnas; la anchura se ajusto varias veces en la PC del lab. | Aun falta recortar el rectangulo exterior. |
| Habia demasiadas opciones que nadie usa. | Se ocultaron controles muertos: palancas, sonido inicial, luz intermitente, retardo y audio izquierdo/derecho. Valores utiles por defecto: luz segura; luz y sonido de riesgo; secuencia y sonido 1:10 activados. | Aplicar solo despues de revisar GUI CP. |
| `Secuencia Aleatoria` genera ansiedad si desaparece. | Se conserva visible y marcada, aunque el callback historico no cambia la secuencia. | Mantener por compatibilidad de uso. |
| Los palanqueos solo se veian como contadores incompletos y no se guardaban. | `EventosPalanqueo` registra segundo, fase, ensayo, tipo, lado y contador fisico. Al guardar se crea un `.mat` y un CSV hermano. | Aplicar despues de validar el contador fisico. |
| El contador de ensayos ignoraba los no-cruces. | **En rama `feature/sensor-validated-crosses`:** `Ensayos terminados` es el numero de filas en `Resultados`. Incluye cruce, repeticion, `-2` y sonido solo completo; no cuenta un ensayo abortado sin fila. | Pendiente prueba fisica y transferencia. |

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
  `tiempo_s`, `fase`, `ensayo`, `tipo_evento`, `lado`,
  `contador_hardware`.
- Fases actuales: `habituacion_inicial`, `sin_luz`, `ensayo` y
  `habituacion_final`.

La prueba de sesion con rata genero el archivo correctamente y mostro saltos
rapidos del contador. La prueba fisica controlada posterior los aclaro: una
presion lenta por lado genero exactamente un incremento; tres presiones rapidas
generaron exactamente tres. No se observo rebote en esa prueba. Por tanto, los
saltos de la sesion probablemente fueron presiones reales repetidas mientras la
rata o el operador intentaban completar la deteccion corporal por los laseres.

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
| Hacer que `Ensayos a realizar` use ensayos terminados segun la regla acordada. | **Implementado:** el programa termina al llegar al numero de filas/ensayos completos, sin contar un paro a mitad de evento. Falta confirmar visualmente el cierre automatico tras el ultimo ensayo. |
| Cronometros de habituacion inicial y final. | La GUI muestra tiempo transcurrido y el tiempo configurado se cumple. |
| Finalizacion automatica. | **En rama `feature/sensor-validated-crosses`:** tras la habituacion final se abre el dialogo nativo de guardado desde `C:\` para elegir USB en Este equipo; guarda `.mat` y CSV juntos. Cancelar conserva el estado temporal para el boton manual. Falta aviso LED opcional y prueba fisica. |
| Ajustar el rectangulo exterior de `uitable1`. | El ancho exterior de la tabla coincide con sus nueve columnas, sin espacio interno sobrante ni columna oculta en R2011a. |
| Transferir los cambios a `OA_ValentiaCuatroE2`. | Simulacion y prueba fisica CP completadas antes de uso experimental. |

## Regla De Trabajo

Cada pendiente se implementa primero en Discriminacion, se prueba sin hardware,
luego con la caja y solo entonces se adapta a Cruces Peligrosos. No copiar una
GUI completa sin revisar sus diferencias conductuales.
