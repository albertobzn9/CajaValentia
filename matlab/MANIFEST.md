# Manifest De La Carpeta Limpia

Carpeta: `06_matlab_limpio_usb`

Objetivo: conservar solo el MATLAB esencial para operar la Caja CMC segun el
manual, sin copiar variantes historicas ni pruebas.

## Fuente De Esta Version

Esta version fue realineada con el diagnostico del lab del 2026-06-11. Para
cada funcion se tomo como base la ruta que MATLAB resolvia con `which` en la
computadora del lab y despues se quitaron rutas absolutas antiguas para que la
copia funcione desde USB.

## Entrada

- `abrir.m`: wrapper local; redirige el comando historico a `abrir1`.
- `abrir1.m`: menu depurado nuevo.
- `cmc_root.m`: calcula la raiz de la copia USB.
- `cmc_setup_paths.m`: agrega rutas necesarias.
- `cmc_state_dir.m`: apunta a `Valentia`, donde viven `.mat` de estado.
- `cmc_results_dir.m`: apunta a `resultados`, dentro del USB.

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

## Carpeta De Resultados

- `resultados/`: destino local para guardar/cargar `.mat` desde el USB.

## Excluido A Proposito

- variantes `CuatroC`, `CuatroD`, `E3`, `Conflicto`, `Mayo31`;
- `OA_Condicionamiento.m` simple;
- `prueba*.m`, `ejemplo1.m`;
- carpetas de pruebas;
- archivos `.asv`;
- resultados historicos no necesarios para arrancar.
