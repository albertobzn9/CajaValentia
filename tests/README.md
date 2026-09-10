# Tests

MATLAB test scripts live in `matlab/` so they can use the same path setup as the
runnable program:

- `cmc_prueba_sin_hardware_completa` - recommended full suite.
- `cmc_prueba_secuencia_sonido_solo`
- `cmc_simulacion_discriminacion_sonido_solo`
- `cmc_prueba_plan_sonido_solo_cp`
- `cmc_simulacion_cp_sonido_solo`
- `problema_1_conteo_ensayos_cruce/cmc_prueba_conteo_ensayos_cruce` -
  conteo, secuencia suficiente y cierre por ensayos programados de cruce.
- `problema_focos_comida/cmc_prueba_temporizacion_estimulos` - tramas y
  pausas legacy del bus de estimulos, sin acceso a la tarjeta NI.
- `problema_focos_comida/cmc_prueba_foco_objetivo` - exclusion del foco
  contrario para eventos seguros y de riesgo, incluidos eventos del mismo lado.

La prueba fisica `cmc_prueba_fisica_focos_comida` vive en `matlab/`. Solo
enciende focos de comida y el LED marcador; no usa audio, descarga ni pellet.
Requiere caja vacia y una persona entrenada presente.

They are intended to exercise task logic without DAQ hardware. They are not a
substitute for a supervised physical-box test.

`tests/lab/Abrir_CajaValentia_CrucesSensor.bat` es el lanzador supervisado
vigente de R2011a. Registra su salida de MATLAB en `resultados/`. Los
lanzadores RC3 se retiraron de `main`; siguen disponibles en la etiqueta
historica `v2.0.0-rc.3`.
