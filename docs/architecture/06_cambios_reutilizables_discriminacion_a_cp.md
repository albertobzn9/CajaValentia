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
| Definir ensayo valido para el contador de cruces. | Un cruce real usa posicion inicial confirmada por sensores y llegada al lado opuesto; un inicio desde el centro no infla el contador. La latencia menor a 1 s queda como bandera de calidad, no como unica regla. |
| Contar no-cruces como ensayos terminados. | Una fila con lado `-2` suma al avance experimental aunque no sume al contador de cruces reales. |
| Hacer que `Ensayos a realizar` use ensayos terminados segun la regla acordada. | El programa termina solo al llegar al numero correcto de ensayos completados, sin depender de cortar manualmente. |
| Cronometros de habituacion inicial y final. | La GUI muestra tiempo transcurrido y el tiempo configurado se cumple. |
| Finalizacion automatica. | Tras detener: habituacion final, aviso LED opcional por palomita, dialogo de guardado y retorno seguro a espera. |
| Ajustar el rectangulo exterior de `uitable1`. | El ancho exterior de la tabla coincide con sus nueve columnas, sin espacio interno sobrante ni columna oculta en R2011a. |
| Transferir los cambios a `OA_ValentiaCuatroE2`. | Simulacion y prueba fisica CP completadas antes de uso experimental. |

## Regla De Trabajo

Cada pendiente se implementa primero en Discriminacion, se prueba sin hardware,
luego con la caja y solo entonces se adapta a Cruces Peligrosos. No copiar una
GUI completa sin revisar sus diferencias conductuales.
