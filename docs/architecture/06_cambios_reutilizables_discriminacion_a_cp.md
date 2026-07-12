# Cambios Reutilizables: Discriminacion A Cruces Peligrosos

Alcance: cambios aplicados en `OA_ValentiaCuatroE` (Discriminacion). Este
documento es la lista de transferencia para `OA_ValentiaCuatroE2` (Cruces
Peligrosos), no una afirmacion de que ya esten aplicados ahi.

## Cambios Ya Aplicados En Discriminacion

| Problema simple | Resolucion tecnica | Estado para CP |
|---|---|---|
| MATLAB podia abrir codigo viejo por accidente. | `abrir1` y `cmc_prepara_entorno_r2011a` restauran el path y cargan solo la copia portable. | Reutilizable sin cambio. |
| Habia demasiadas opciones que nadie usa. | Se ocultaron controles muertos y se fijaron valores utiles por defecto: luz segura; luz y sonido de riesgo; secuencia aleatoria y evento sonido activados. | Aplicar solo despues de revisar la GUI CP. |
| El ruido blanco podia iniciar en 5000 Hz. | `cmc_frecuencia_ruido_predeterminada` fija 15000 Hz para todos los modulos que ya la usan. | Ya compartido. |
| Faltaba un evento de solo sonido. | Tipo de evento `2`: ruido blanco, LED marcador y parrilla, sin luz de comida ni pellet. Dura 180 s completos. | CP ya tiene planificacion de tipo `2`; falta validar su flujo completo. |
| Sonido solo aparecia aun en cruces seguros. | En Discriminacion solo se agrega cuando riesgo es mayor que cero y el checkbox `Agregar evento sonido 1:10` esta activo. | No copiar literalmente: CP usa programacion por tiempo. |
| Riesgo y sonido solo no debian existir si la rata no cambia de lado. | La secuencia los coloca solo en cambios de lado. | Regla comun que CP debe conservar. |
| La tabla no distinguia los tres tipos de evento. | Columna 9 `Tipo`: 0 seguro, 1 riesgo, 2 sonido solo. La vista es compacta; el `.mat` conserva precision completa. | Aplicar. |
| Un evento de solo sonido podia congelar su reloj cuando la rata cruzaba. | `OA_MonitoreaSonidoSolo` mantiene el reloj y el evento por toda su duracion. | Aplicar al monitor CP. |
| Detener podia perder datos o cortar un ensayo a medias. | `Detener ahora` termina de inmediato sin inventar una fila; `Detener tras ensayo` termina al cerrar el evento actual. Ambos botones conservan texto estable. | Aplicar. |
| Los palanqueos solo se veian como contadores incompletos y no se guardaban. | `EventosPalanqueo` registra segundo, fase, ensayo, tipo, lado y contador fisico. Al guardar se crea un `.mat` y un CSV hermano. | Aplicar despues de validar el contador fisico. |
| La habituacion final quedaba fuera de los datos. | El registro de palanqueos incluye `habituacion_final` y el estado temporal se guarda despues de esa fase. | Aplicar junto con el flujo final CP. |

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

La primera prueba real genero el archivo correctamente. Tambien mostro saltos
rapidos del contador fisico, por ejemplo varios incrementos durante una sola
lectura. Antes de usarlo como medida biologica se debe hacer una prueba
controlada: una presion lenta por vez, por ambos lados, y comparar video,
palanca real y CSV. El CSV es ahora la evidencia para diagnosticar ese
problema; aun no demuestra que cada incremento sea una presion real.

## Pendientes Antes De Copiar A CP

| Pendiente | Criterio de terminado |
|---|---|
| Validar palanqueos con prueba fisica controlada. | Una presion conocida produce una sola fila; cualquier rebote queda caracterizado. |
| Definir ensayo valido para el contador de cruces. | Un cruce real cambia de lado; un inicio desde el centro no infla el contador. Los no-cruces tambien cuentan como ensayo terminado. |
| Hacer que `Ensayos a realizar` use ensayos terminados segun la regla acordada. | El programa termina solo al llegar al numero correcto, sin depender de cortar manualmente. |
| Cronometros de habituacion inicial y final. | La GUI muestra tiempo transcurrido y el tiempo configurado se cumple. |
| Finalizacion automatica. | Tras detener: habituacion final, aviso LED opcional, dialogo de guardado y retorno seguro a espera. |
| Ajustar el rectangulo exterior de `uitable1`. | No queda espacio vacio sobrante ni se oculta la columna 9 en R2011a. |
| Transferir los cambios a `OA_ValentiaCuatroE2`. | Simulacion y prueba fisica CP completadas antes de uso experimental. |

## Regla De Trabajo

Cada pendiente se implementa primero en Discriminacion, se prueba sin hardware,
luego con la caja y solo entonces se adapta a Cruces Peligrosos. No copiar una
GUI completa sin revisar sus diferencias conductuales.
