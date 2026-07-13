# Tests

MATLAB test scripts live in `matlab/` so they can use the same path setup as the
runnable program:

- `cmc_prueba_sin_hardware_completa` - recommended full suite.
- `cmc_prueba_secuencia_sonido_solo`
- `cmc_simulacion_discriminacion_sonido_solo`
- `cmc_prueba_plan_sonido_solo_cp`
- `cmc_simulacion_cp_sonido_solo`

They are intended to exercise task logic without DAQ hardware. They are not a
substitute for a supervised physical-box test.

`tests/lab/Abrir_CajaValentia_CrucesSensor.bat` es el lanzador supervisado
vigente de R2011a. Registra su salida de MATLAB en `resultados/`. Los
lanzadores RC3 se retiraron de `main`; siguen disponibles en la etiqueta
historica `v2.0.0-rc.3`.
