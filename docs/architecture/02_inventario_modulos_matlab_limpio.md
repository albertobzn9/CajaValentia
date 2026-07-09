# Inventario De Modulos Del MATLAB Limpio

Alcance: archivos `.m` de `06_matlab_limpio_usb` que participan en el menu
operativo. Las funciones dentro de una GUI son callbacks del mismo archivo.

## Arranque

| Archivo | Hace | Depende de |
|---|---|---|
| `abrir.m` | Redirige el comando historico al menu limpio. | `abrir1` |
| `abrir1.m` | Muestra las cinco tareas activas. | Rutas USB y GUIs. |
| `cmc_root.m` | Encuentra la raiz de la carpeta USB. | Nada. |
| `cmc_setup_paths.m` | Agrega carpetas necesarias a MATLAB. | `cmc_root`, `cmc_results_dir`. |
| `cmc_state_dir.m` | Ubica los archivos de estado. | `cmc_root`. |
| `cmc_results_dir.m` | Ubica o crea `resultados`. | `cmc_root`. |

## Tareas

| Archivo | Hace | Usa directamente |
|---|---|---|
| `Valentia/OA_ValentiaEntrenaPalancasCP.m` | Moldeamiento por palanca. | Tarjeta, audio, palancas, recompensa. |
| `OA_ValentiaEntrenaPalancasCPE.m` | EntrenaE, luz-comida. | Tarjeta, audio, palancas, recompensa. |
| `OA_ValentiaCuatroE.m` | Cruces seguros/discriminacion/prueba. | Secuencia 3, sensores, estimulos, recompensa, resultados. |
| `OA_ValentiaCuatroE2.m` | Cruces peligrosos. | Secuencia 4, sensores, estimulos, descarga, recompensa, resultados. |
| `OA_Condiciona_Aleatorio.m` | Condicionamiento aversivo. | Tarjeta, audio, estimulos, descarga. |

## Tarjeta, Audio Y Secuencias

| Archivo | Hace | Usa directamente |
|---|---|---|
| `Valentia/OA_ValentiaInicio.m` | Abre la tarjeta NI como `Dev2`. | `escribePto`; driver de NI. |
| `Valentia/escribePto.m` | Escribe lineas de salida de la tarjeta. | Objeto de tarjeta. |
| `Valentia/OA_PreparaSonidos.m` | Abre audio estereo de Windows. | Driver de audio. |
| `Valentia/OA_Sonidos.m` | Genera tono o ruido. | Audio preparado. |
| `Valentia/OA_FinSonidos.m` | Genera sonido final; no es central en el menu actual. | `OA_Sonidos`. |
| `Valentia/OA_Secuencia.m` | Alterna lados sin demasiadas repeticiones. | Numeros aleatorios. |
| `Valentia/OA_SecuenciaEnsayos3.m` | Crea secuencia para `ValentiaE`. | `OA_Secuencia`, `OA_ValentiaRiesgo`. |
| `Valentia/OA_SecuenciaEnsayos4.m` | Crea secuencia para `ValentiaE2`. | `OA_Secuencia`, `OA_ValentiaRiesgo`. |
| `Valentia/OA_ValentiaRiesgo.m` | Distribuye riesgo por bloques de diez. | Numeros aleatorios. |
| `Valentia/OA_CtrlDispIzq.m` y `OA_CtrlDispIzqCero.m` | Control/limpieza de dispensador. | `escribePto`. |

## Sensores Y Acciones Fisicas

| Archivo | Hace |
|---|---|
| `Valentia/valentia/OA_ValentiaBuscaIzquierda.m` | Detecta llegada/cruce izquierdo. |
| `Valentia/valentia/OA_ValentiaBuscaDerecha.m` | Detecta llegada/cruce derecho. |
| `Valentia/valentia/OA_ValentiaRevisaPalanca.m` | Lee los contadores de palanca. |
| `Valentia/valentia/OA_ValentiaEstimuloI.m` | Controla estimulo izquierdo: sonido/LED/luz. |
| `Valentia/valentia/OA_ValentiaEstimuloD.m` | Controla estimulo derecho: sonido/LED/luz. |
| `Valentia/valentia/OA_ValentiaRecompensaI.m` | Da pellet izquierdo. |
| `Valentia/valentia/OA_ValentiaRecompensaD.m` | Da pellet derecho. |
| `Valentia/valentia/OA_ValentiaElectrico.m` | Enciende o apaga descarga. |
| `Valentia/valentia/OA_ValentiaPalanca.m` | Muestra u oculta palancas. |
| `Valentia/valentia/OA_ValentiaResetPalancas.m` | Reinicia contadores de palanca. |

## Archivos De Estado

Los `.mat` no son modulos, pero el programa los necesita para recordar
parametros y resultados: `ControlTarea`, `Riesgo`, `RetardoRecomp`,
`PelletsEvento`, `controlEnt`, `controlEntD`, `controlPellet`,
`controlPelletD`, `DetenerC`, `Resultados`, `OA_Resultados` y `DatosValentia`.

`PelletsEventoRiesgo.mat` se crea al editar ese parametro; no necesita venir
preinstalado para abrir el programa.

## Dependencias Fuera Del USB

La carpeta contiene todo el codigo propio. Aun requiere MATLAB R2011a, el
driver/tarjeta National Instruments disponible como `Dev2` y audio de Windows.

Para señales fisicas y lineas de tarjeta: [Mapa de hardware](../../03_hardware_io/mapa-io-hardware-caja-valentia.md).
