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

`tests/lab/` contains Windows launchers for supervised R2011a checks. Each
launcher records a MATLAB launcher log under `resultados/`; the audio and
sound-only diagnostics also save their own `.txt` log and `.mat` artifact.
