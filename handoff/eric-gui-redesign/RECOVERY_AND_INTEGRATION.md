# Recuperacion E Integracion Antes Del Rediseño GUIDE

Inicio: 20-jul-2026. Esta guia complementa el [README](README.md): no lo reemplaza. El encargo de Eric conserva el rediseño GUIDE, pero empieza por una auditoria breve y controlada de las funciones que existieron antes de la restauracion de `main`.

## Objetivo Real

Recuperar **una funcion conductual o de datos a la vez**, con su prueba, y llevarla a `main` solo despues de revisar su comportamiento. La interfaz nueva debe consumir un solo backend coherente; no debe mezclar archivos de versiones historicas ni ocultar cambios de logica dentro de un ajuste visual.

No es objetivo recuperar toda la rama experimental ni hacer otra reescritura. Tampoco se modifica `legacy/`, la tarjeta NI, audio, luces, pellet, parrilla o sensores sin prueba separada.

## Lectura Inicial Obligatoria

1. [`../../AGENTS.md`](../../AGENTS.md).
2. [`../../docs/START_HERE_NEW_AGENT.md`](../../docs/START_HERE_NEW_AGENT.md).
3. [`../../docs/current-runtime-behavior-and-known-limitations.md`](../../docs/current-runtime-behavior-and-known-limitations.md).
4. [`../../docs/validation.md`](../../docs/validation.md).
5. Este archivo y [BACKEND_CONTRACT.md](BACKEND_CONTRACT.md).

El README original de este handoff describe la entrega visual sobre `runtime-v1-clean/` (tag `v1.0.0`). Eso sigue siendo el punto de partida para maquetas y controles GUIDE. La recuperacion de comportamiento se hace exclusivamente en `../../matlab/` desde `main`, en ramas separadas.

## Foto De Referencias: 19-jul-2026

| Referencia | Significado | Uso para Eric |
| --- | --- | --- |
| `main` / `origin/main` en `dae7060` | Runtime R2011a restaurado y fuente operativa actual. | Base de toda rama nueva. |
| `v1.0.0` en `0489496` | Base limpia entregada originalmente para la GUI. | Referencia visual/backend V1 del handoff. |
| `v2.0.0-rc.4-discriminacion-validada` en `39020db` | Hito historico de Discriminacion con cambios amplios. | Fuente de investigacion, no de merge directo. |
| `feature/discriminacion-cierre-habituacion` en `f784950` | Archivo experimental posterior, con 7 commits no presentes en `main`; el commit local final no esta en `origin`. | Comparar funciones puntuales; no fusionar ni borrar. |
| `feature/cp-time-aware-sound-only` en `71b879c` | Trabajo separado de Cruces Peligrosos, con 7 commits no presentes en `main`. | Recuperar solo con prueba propia de CP. |
| `migration/r2022a-r2026a-ni-usb6501` | Investigacion de migracion moderna. | No es runtime R2011a ni fuente de GUI GUIDE. |

`main` se restauro deliberadamente mediante `ebbb3b8` y `f63cee0`. La linea experimental acumulaba cambios de conteo, CSV, limites y GUI que no se podian diagnosticar juntos. La restauracion no significa que cada funcion eliminada sea incorrecta; significa que debe volver con alcance pequeno y evidencia propia.

## Estado Local Que No Se Debe Perder

Este worktree no esta limpio. Antes de cambiar de rama, hacer `git status --short` y **no usar** `reset`, `checkout --`, `clean` ni un stash destructivo. Hay una propuesta sin commit para `ValentiaE` que intenta recuperar tres cosas:

- contador y corte por `Cruces validos`;
- apagado fiable del LED al guardar, cancelar o reiniciar;
- CSV principal de nueve columnas y CSV de palanqueos con CSV por defecto.

Sus archivos principales son `matlab/OA_ValentiaCuatroE.m`, `cmc_detener_aviso_led_final.m`, `cmc_iniciar_aviso_led_final.m`, `cmc_guardar_resultados_sesion.m`, `cmc_solicitar_guardado_final.m` y los nuevos `cmc_objetivo_cruces_alcanzado.m`, `cmc_escribir_csv_resultados.m`, `cmc_prueba_conteo_cruces_validos.m` y `cmc_prueba_cierre_sin_hardware.m`.

Esa propuesta es **evidencia de trabajo, no version aprobada**: no tiene commit ni prueba final de caja. Antes de que Eric la toque, crear una rama de resguardo con el responsable del repositorio o comparar su diff contra los commits de la tabla siguiente. Nunca mezclarla en la rama de UI.

## Inventario De Recuperacion

La prioridad es validar primero el comportamiento que el equipo ya observo como necesario. Cada fila representa una rama y un pull request independientes.

| Prioridad | Funcion y semantica deseada | Referencias para estudiar | No traer sin revisar | Prueba de aceptacion |
| --- | --- | --- | --- | --- |
| 1 | **Cruces validos:** solo cambio de lado, origen lateral confirmado y desplazamiento >= 1 s cuentan y terminan la meta. No cuentan no-cruces, mismo lado, centro ni sonido solo. | `2f3adbf` agrega lectura/clasificacion y `cmc_es_cruce_valido`; propuesta local sin commit agrega objetivo y prueba. | `81c2445` cuenta filas con timeout. `0f6f1a6` y `cmc_cuenta_ensayo_cruce` contaban ciertos no-cruces laterales por otra regla experimental. | Suite sin hardware; en caja: 29 no terminan, el cruce valido 30 termina despues de cerrar su evento, y un no-cruce no aumenta el contador. |
| 2 | **Cierre y LED final:** el LED solo parpadea durante el dialogo y se apaga al guardar, Escape/cancelar, cerrar GUI o empezar otra sesion. | `f546242` (aviso LED), `7c3f4ca` (guardado final), `09b8aa5` (diagnosticos); propuesta local de limpieza de timers. | No copiar archivos de resultados de sesiones ni cambios de tabla asociados. | Prueba de timer sin hardware; en caja: guardar, cancelar con Escape y reiniciar una sesion sin LED residual. |
| 3 | **Exportacion CSV de nueve columnas:** dialogo con CSV por defecto; guardar CSV principal y `*_palanqueos.csv`. | `d72a6c1`; propuesta local `cmc_escribir_csv_resultados.m`. Para CP, `fbd60d6` solo cambia el dialogo. | `0f6f1a6`, que introduce diez columnas y `ensayo_cruce`. | Prueba sin hardware de encabezado, extension y ambos archivos; prueba corta de guardado manual/final en R2011a. |
| 4 | **Parada inmediata versus tras ensayo en ValentiaE.** | `4006152`. | Cambios de contador, CSV o secuencia que aparezcan en el mismo diff. | Prueba de logica y prueba corta supervisada de ambos botones. |
| 5 | **CP: limite tras cruce sin palanqueo.** | `b0577ff`. | Integrar CP junto con Discriminacion o asumir que el limite es conductualmente correcto. | Prueba sin hardware y prueba fisica exclusiva de CP: cruce sin palanqueo, limite esperado y apagado seguro. |
| 6 | **CP: sonido solo programado por tiempo.** | `1110ce1` (planificador) y `3ba0f4a` (integracion). | El cierre por numero de cruces de Discriminacion. CP termina por tiempo de sesion. | Prueba sin hardware y sesion fisica dedicada: eventos cerca de 9, 18 y 27 min, sin pellet ni luz de comida. |

El tag `v2.0.0-rc.4-discriminacion-validada` contiene evidencia historica de sonido solo, CSV y contador, pero su contador `Ensayos de cruce` tuvo una regla distinta: contaba no-cruces laterales para evitar sesiones interminables con ratas temerosas. Esa puede ser una decision conductual valida, pero **no es** la regla solicitada hoy para `Cruces validos`; se debe discutir por separado.

## Procedimiento Por Funcion

1. Actualizar referencias y partir de `main`:

   ```bash
   git fetch --prune origin
   git switch main
   git pull --ff-only
   git switch -c eric/recuperar-nombre-corto
   ```

2. Leer el cambio antes de copiarlo:

   ```bash
   git show --stat COMMIT
   git show COMMIT -- matlab/ARCHIVO.m
   git diff --stat main...REFERENCIA
   ```

3. Llevar solo los modulos, llamadas y pruebas indispensables. Preferir `git cherry-pick -n COMMIT` para inspeccionar el diff y seleccionar partes; no hacer merge completo de una rama historica.

4. Ejecutar `cmc_prueba_sin_hardware_completa` con MATLAB compatible. Esta prueba no valida NI, audio, sensores ni pellet.

5. Escribir en `docs/validation.md` el criterio de prueba fisica corta. Solo una persona presente frente a la caja inicia, detiene o decide sobre la sesion; no lanzar GUI ni salidas de hardware por SSH.

6. Hacer un commit con una sola funcion, su prueba y su actualizacion documental. No versionar `.mat` generados, CSV de sesion ni identificadores de animales. Abrir revision antes de integrar a `main`.

## Contrato Entre UI Y Backend

- La UI nueva puede cambiar disposicion, nombres de controles y claridad visual, pero no decide conteos, secuencias, tiempos, recompensa o salidas.
- `abrir.m -> abrir1.m` conserva el menu completo de cinco tareas. No sustituir el menu por una interfaz reducida.
- Nunca agregar a MATLAB simultaneamente `runtime-v1-clean/` y `matlab/`: hay funciones con el mismo nombre y se puede ejecutar la version equivocada.
- Cada GUI debe bloquear parametros al iniciar una sesion y desbloquearlos al terminar; el selector de backend futuro se elige antes de abrir una tarea y nunca en medio de una sesion.
- La UI puede avanzar en una rama propia (`eric/ui-guide-shell`) mientras las recuperaciones avanzan en ramas separadas. La union ocurre solo cuando una recuperacion ya esta aprobada en `main`.

## Primer Dia De Eric

1. Leer los documentos iniciales y confirmar el estado de Git sin modificar el worktree sucio.
2. Generar una tabla corta de `commit -> archivos -> conducta -> prueba` para las prioridades 1 a 3.
3. Elegir **solo una** recuperacion con el manager. Recomendacion: contador de cruces validos, porque fue el fallo observado directamente en la prueba.
4. Crear su rama de recuperacion, escribir o ajustar su prueba pura y presentar el diff antes de tocar la GUI o la PC del laboratorio.
5. En paralelo, abrir los bocetos y planear la estructura GUIDE sin conectar aun controles a una rama historica.

## Criterio De Exito Del Encargo

Al final de cada entrega debe poder responderse sin ambiguedad:

- Que funcion cambio y que conducta se espera.
- Que commit historico se uso como antecedente.
- Que archivos se cambiaron y por que.
- Que prueba sin hardware paso.
- Que prueba fisica falta o paso, con resultado esperado frente a observado.

Si una de esas respuestas falta, la funcion se conserva en su rama y no entra a `main` todavia.
