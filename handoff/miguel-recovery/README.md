# Handoff Para Miguel: Recuperacion Del Runtime CMC

Fecha de preparacion: 2026-08-18.

## Proposito

Miguel es el nuevo responsable tecnico. Este documento explica la tarea
conductual, el estado real del software y el plan de recuperacion. La prioridad
no es una reescritura ni una GUI nueva: es recuperar un runtime R2011a que haga
exactamente lo acordado por el laboratorio, mediante cambios pequenos,
revisables y probables con la caja.

## Lectura Minima

1. [Reglas del repositorio](../../AGENTS.md).
2. [Estado actual y limites](../../docs/current-runtime-behavior-and-known-limitations.md).
3. [Validacion](../../docs/validation.md).
4. Este documento.
5. [Articulo CMC de Illescas-Huerta et al. (2021)](https://doi.org/10.3389/fnins.2021.645769).

El articulo es el contexto conductual, no una especificacion literal de cada
callback MATLAB. Las extensiones locales, como solo sonido y los CSV, deben
declararse por separado.

## La Tarea En Terminos Simples

La tarea principal es Crossing-Mediated Conflict (CMC), descrita por
Illescas-Huerta et al. (2021). Una rata con motivacion por comida empieza en un
extremo seguro de un pasillo. Una luz en el extremo opuesto indica que puede
cruzar y presionar una palanca para obtener un pellet.

- Ensayo seguro: la rata cruza sin amenaza para llegar a comida.
- Ensayo de riesgo: la luz de comida coincide con ruido y una parrilla
  electrificada. La rata decide si se acerca a la recompensa pese a la amenaza.
- La variable central es la latencia para cruzar y completar la palanca. Que no
  cruce tambien es un resultado, no un dato que se deba borrar.

El pasillo del articulo tiene dos zonas seguras en los extremos y una zona
central de amenaza. La version de discriminacion usa bloques de ensayos seguros
y de riesgo; cada uno da un maximo de 180 segundos para decidir cruzar. El
articulo incluye exposicion de contexto sin estimulos al inicio y al final, y
sus sesiones de discriminacion tienen 30 ensayos programados.

Punto crucial: una politica reciente del laboratorio pide terminar despues de
30 cruces validos, no despues de 30 ensayos programados. Esa es una decision
operativa local, distinta de la definicion del articulo. El software debe
guardar todos los ensayos y no-cruces como datos, pero incrementar la meta solo
con los cruces que cumplan el criterio local. Miguel no debe cambiar esa regla
sin autorizacion del responsable conductual.

El programa tambien tiene moldeamiento, luz-comida, Cruces Peligrosos (CP) y
condicionamiento aleatorio. El articulo CMC explica principalmente la logica de
cruces y conflicto; no certifica por si solo cada una de esas GUIs.

## Que Controla El Programa

Ruta de entrada:

    matlab/abrir.m -> matlab/abrir1.m -> menu de cinco tareas
      -> OA_ValentiaCuatroE.m    Discriminacion / cruces seguros
      -> OA_ValentiaCuatroE2.m   Cruces Peligrosos
      -> OA_ValentiaEntrenaPalancasCPE.m
      -> Valentia/OA_ValentiaEntrenaPalancasCP.m
      -> OA_Condiciona_Aleatorio.m

Cada GUI abre dependencias reales: la tarjeta National Instruments antigua es
Dev2, el audio usa winsound y los estados se intercambian mediante archivos MAT
en matlab/Valentia/. Un cambio visual puede alterar luces, pellet, parrilla,
audio o el estado de otra tarea.

Nunca abrir GUI ni ejecutar una salida de hardware de forma remota. Las pruebas
de logica no validan tarjeta, sensores, palancas, audio ni dispensadores.

## Estado Actual: Por Que No Cumple El Objetivo

La rama main en dae7060 es una base restaurada, no una entrega final. Fue
restaurada porque se habian agrupado cambios de conteo, guardado, limites, GUI y
CP, de modo que un fallo ya no se podia aislar.

Para ValentiaE, main tiene estos problemas frente a la meta actual:

| Tema | Que hace main | Por que es insuficiente |
| --- | --- | --- |
| Conteo y final | Muestra Ensayos terminados y cuenta filas, incluso no-cruces y solo sonido. | No implementa la meta local de 30 cruces validos. |
| Cruce valido | cmc_es_cruce_valido calcula cambio de lado, origen lateral y desplazamiento >= 1 s, pero solo se imprime. | La regla no controla contador ni fin. |
| Datos | Guarda un MAT final y un CSV de palanqueos. | Falta el CSV principal pedido para analisis directo. |
| LED final | Hay aviso opcional al guardar. | Debe comprobarse al guardar, Escape, cerrar GUI y reiniciar. |
| Espera tras llegada | El limite termina la espera de cruce, no la espera posterior de palanca. | Una rata que llega y no palanquea puede dejar el ensayo activo. Se conserva por ahora. |
| CP | Tiene ITI bloqueante y espera sin limite tras cruzar sin palanquear. | No esta validado para uso experimental con los cambios posteriores. |

Main puede abrirse como referencia conservadora, pero no debe presentarse como
la version que satisface las decisiones pendientes de conteo y exportacion.

## Que Version Funcionaba Antes

La mejor evidencia para Discriminacion o ValentiaE es:

    tag:    v2.0.0-rc.4-discriminacion-validada
    commit: 39020dbc00b094a071d5340c3430f866b29fff0a
    fecha:  2026-07-12

Tiene evidencia documentada de prueba R2011a y caja para arranque, audio
estereo, solo sonido, controles de detener y una version de CSV y conteo. Es la
mejor referencia para entender un runtime que ya opero.

No es un rollback automatico:

1. Su contador Ensayos de cruce incluye ciertos no-cruces laterales. Fue una
   regla deliberada para animales temerosos, pero no coincide con la politica
   actual de contar solo cruces validos.
2. Cambia resultados a diez columnas e introduce ensayo_cruce; la recuperacion
   posterior propone nueve columnas.
3. CP no quedo validado como parte de ese tag.

Miguel debe usar este tag como referencia funcional y fuente de commits, no
hacer reset, merge o copia completa hacia main.

| Referencia | Estado | Uso correcto |
| --- | --- | --- |
| main / dae7060 | Base operativa restaurada. | Punto de partida de cada correccion. |
| v2.0.0-rc.4-discriminacion-validada / 39020db | Mejor evidencia de Discriminacion probada. | Comparar y recuperar piezas pequenas. |
| codex/recovery-snapshot-2026-07-20 / 8f85cd5 | Candidato no validado: cruces validos, LED y CSV de nueve columnas. | Revisar como propuesta, no desplegar. |
| feature/cp-time-aware-sound-only / 71b879c | Propuesta CP con limite tras cruce y solo sonido temporal. | Recuperar solo despues de validar Discriminacion. |
| legacy y v0.1.0 | Archivo de auditoria. | Leer para entender, nunca editar ni desplegar directo. |

## Alcance Tecnico Que Se Debe Recuperar

Cada punto requiere su propia rama, prueba y revision.

1. ValentiaE: contador de cruces validos y fin automatico. Solo cuentan cambio
   de lado, origen lateral confirmado y desplazamiento de al menos 1 s. No
   suman no-cruces, mismo lado, origen central ni solo sonido. Los no-cruces se
   registran como datos.
2. ValentiaE: cierre limpio del LED final. Se apaga al guardar, Escape,
   cerrar GUI o iniciar otra sesion. No debe sobrevivir ningun timer.
3. ValentiaE: exportacion. Guardar CSV principal de nueve columnas y CSV hermano
   de palanqueos; CSV debe ser el formato predeterminado. MAT puede persistir
   solo como estado interno de MATLAB.
4. ValentiaE: controles de parada. Recuperar y probar Detener ahora versus
   Detener tras ensayo, sin filas falsas ni salidas activas.
5. CP: limite despues de cruzar sin palanquear. Recuperar b0577ff solo con
   prueba propia de CP. CP termina por tiempo, no por cruces.
6. CP: solo sonido programado por tiempo. Revisar 1110ce1 y 3ba0f4a. No da luz
   de comida ni pellet y debe ocurrir entre ensayos normales.

Fuera de alcance por decision previa: el limite especial para eventos de mismo
lado. No introducirlo en esta recuperacion.

## Plan De Trabajo

### Fase 0: Congelar Y Medir

    git fetch --prune origin
    git switch main
    git pull --ff-only
    git status --short
    git show 39020db -- matlab/OA_ValentiaCuatroE.m
    git diff --stat main...codex/recovery-snapshot-2026-07-20

No trabajar sobre una copia del Escritorio de laboratorio. No usar reset hard,
checkout de descarte ni fusionar ramas historicas completas.

### Fase 1: Primera Entrega De Discriminacion

Crear una rama desde main, por ejemplo miguel/valentiae-cruces-validos. Llevar
solo llamadas y helpers para que contador y fin usen cmc_es_cruce_valido. Agregar
una prueba pura que cubra:

- 29 de 30 cruces no finalizan.
- 30 de 30 cruces validos finalizan al cerrar el evento.
- No-cruce, mismo lado, centro y desplazamiento de 0.99 s no incrementan.
- Desplazamiento de 1.00 s si incrementa.

No agregar CSV, LED, CP ni cambios de GUI en esa entrega.

### Fase 2: Datos Y Cierre

En ramas independientes, recuperar CSV y ciclo de vida LED. La fuente mas
directa es codex/recovery-snapshot-2026-07-20, pero cada diff debe compararse
con main y con los commits d72a6c1, f546242 y 7c3f4ca.

### Fase 3: CP

Solo cuando Discriminacion este validada con caja. CP tiene reglas distintas y
no debe recibir copia y pega de OA_ValentiaCuatroE.m.

## Pruebas Obligatorias

1. Ejecutar cmc_prueba_sin_hardware_completa con MATLAB compatible y guardar su
   salida.
2. Ejecutar la prueba exacta nueva de la funcion modificada.
3. Hacer una prueba fisica corta con una persona entrenada frente a la caja.
4. Documentar commit, MATLAB, PC, parametros, resultado esperado, observado y
   archivos de salida.
5. Solo entonces proponer merge a main.

La Mac moderna sirve para analisis o simulacion, pero no reemplaza Windows con
MATLAB R2011a, tarjeta NI ni audio de laboratorio.

## Modulos Que Miguel Debe Seguir

| Pregunta | Modulos principales |
| --- | --- |
| Menu y rutas | abrir.m, abrir1.m, cmc_setup_paths.m |
| Discriminacion | OA_ValentiaCuatroE.m, Valentia/OA_SecuenciaDiscriminacionSonidoSolo.m |
| Sensores y cruce valido | cmc_lee_zona_posicion.m, cmc_clasifica_zona_posicion.m, cmc_es_cruce_valido.m |
| Palancas y pellets | OA_ValentiaRevisaPalanca.m, OA_ValentiaRecompensaI.m, OA_ValentiaRecompensaD.m |
| Hardware | OA_ValentiaInicio.m, OA_ValentiaEstimuloI.m, OA_ValentiaEstimuloD.m, OA_ValentiaElectrico.m |
| Audio | OA_PreparaSonidos.m, OA_Sonidos.m |
| Guardado y LED | cmc_solicitar_guardado_final.m, cmc_guardar_resultados_sesion.m, cmc_iniciar_aviso_led_final.m, cmc_detener_aviso_led_final.m |
| CP | OA_ValentiaCuatroE2.m, Valentia/OA_EjecutaSonidoSoloCP.m |

## Regla Final

Miguel implementa; el responsable conductual aprueba semantica. Si una regla
afecta que cuenta como ensayo, cuando termina una sesion, que estimulo recibe
la rata o como se interpreta un no-cruce, no se resuelve por intuicion de
programacion. Se escribe primero como regla conductual, se aprueba y luego se
codifica.

