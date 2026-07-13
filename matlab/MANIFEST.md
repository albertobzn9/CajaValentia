# Manifest Del Runtime MATLAB

Carpeta: `matlab/`

Objetivo: runtime autocontenido de la Caja CMC. Conserva las tareas vigentes,
la capa de hardware, estado minimo y pruebas reutilizables. Las variantes
historicas viven solo en `../legacy/`.

## Fuente De Esta Version

Esta version se realineo con los diagnosticos del laboratorio. Las rutas se
calculan desde la carpeta que contiene `cmc_root.m`; por eso el runtime puede
desplegarse autocontenido, sin depender de las copias viejas de la PC.

## Entrada

- `cmc_iniciar_gui_r2011a.m`: entrada aislada usada por el lanzador diario.
- `abrir.m`: wrapper de compatibilidad; redirige a `abrir1`.
- `abrir1.m`: menu de las cinco tareas operativas.
- `cmc_root.m`: calcula la raiz de esta copia autocontenida.
- `cmc_setup_paths.m`: agrega rutas necesarias.
- `cmc_state_dir.m`: apunta a `Valentia`, donde viven `.mat` de estado.
- `cmc_results_dir.m`: apunta a `resultados/` dentro de esta copia.

## GUIs Activas

- `OA_ValentiaEntrenaPalancasCPE.m/.fig`
- `OA_ValentiaCuatroE.m/.fig`
- `OA_ValentiaCuatroE2.m/.fig`
- `OA_Condiciona_Aleatorio.m/.fig`
- `Valentia/OA_ValentiaEntrenaPalancasCP.m/.fig`

## Soporte De Hardware / Audio / Secuencias

- `Valentia/OA_ValentiaInicio.m`
- `Valentia/escribePto.m`
- `Valentia/OA_PreparaSonidos.m`
- `Valentia/OA_Sonidos.m`
- `Valentia/OA_FinSonidos.m`
- `Valentia/OA_Secuencia.m`
- `Valentia/OA_SecuenciaEnsayos3.m`
- `Valentia/OA_SecuenciaEnsayos4.m`
- `Valentia/OA_ValentiaRiesgo.m`
- `Valentia/OA_CtrlDispIzqCero.m`
- `Valentia/OA_CtrlDispIzq.m`

## Funciones De Bajo Nivel

- `Valentia/valentia/OA_ValentiaEstimuloI.m`
- `Valentia/valentia/OA_ValentiaEstimuloD.m`
- `Valentia/valentia/OA_ValentiaElectrico.m`
- `Valentia/valentia/OA_ValentiaRevisaPalanca.m`
- `Valentia/valentia/OA_ValentiaResetPalancas.m`
- `Valentia/valentia/OA_ValentiaBuscaIzquierda.m`
- `Valentia/valentia/OA_ValentiaBuscaDerecha.m`
- `Valentia/valentia/OA_ValentiaRecompensaI.m`
- `Valentia/valentia/OA_ValentiaRecompensaD.m`
- `Valentia/valentia/OA_ValentiaPalanca.m`

## Archivos `.mat` Incluidos

Se copiaron archivos `.mat` de control y defaults usados por las rutas activas,
incluyendo:

- `ControlTarea.mat`
- `Riesgo.mat`
- `RetardoRecomp.mat`
- `PelletsEvento.mat`
- `controlPellet.mat`
- `controlPelletD.mat`
- `controlEnt.mat`
- `controlEntD.mat`
- `DetenerC.mat`
- `Resultados.mat`
- `OA_Resultados.mat`
- `DatosValentia.mat`

## Resultados

- `resultados/`: destino local de CSV de sesion, registros de palancas y
  `ultima_sesion_guardada.txt`, que permite localizar el ultimo guardado por
  SSH.
- Cada guardado final tambien produce `nombre_resumen.txt` junto a los dos CSV.
- Los `.mat` incluidos son estado de MATLAB; no son entregables de sesion.

## Excluido A Proposito

- variantes `CuatroC`, `CuatroD`, `E3`, `Conflicto`, `Mayo31`;
- `OA_Condicionamiento.m` simple;
- `prueba*.m`, `ejemplo1.m`;
- carpetas de pruebas;
- archivos `.asv`;
- resultados historicos no necesarios para arrancar.
