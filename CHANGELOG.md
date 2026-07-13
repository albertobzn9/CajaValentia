# Changelog

Cambios con significado conductual. Los commits contienen el detalle de
implementacion; las etiquetas conservan fotos inmutables de cada etapa.

## V2.4 - Discriminacion Validada (`v2.0.0-rc.4-discriminacion-validada`) - 2026-07-12

- Valida Discriminacion (`ValentiaE`) en MATLAB R2011a y caja real.
- Agrega evento tipo `2`: solo sonido/parrilla, 180 s, sin luz de comida ni
  pellet, opcional 1:10 y solo cuando hay riesgo.
- Exporta `nombre.csv` con diez columnas y `nombre_palanqueos.csv` con cada
  presion por fase; el dialogo de guardado usa CSV por defecto.
- Define el contador `Ensayos de cruce`: cuenta cruces laterales validos y
  no-cruces laterales; excluye centro, mismo lado, ausencia de deteccion y
  sonido solo.
- Agrega habituacion final, guardado automatico y limite de 60 s para
  no-cruce/mismo lado. Las pruebas fisicas pendientes estan en
  [`docs/architecture/06_cambios_reutilizables_discriminacion_a_cp.md`](docs/architecture/06_cambios_reutilizables_discriminacion_a_cp.md).

## V2.3 - Resultados Con Tipo De Evento (historico)

- Introdujo la novena columna `tipo_evento` y la primera prueba de resultados
  con sonido solo. La rama y etiqueta historicas se conservan para comparar.

## V2.2 - Validacion De Software (`v2.0.0-rc.2`)

- Adds one no-hardware suite for the relevant discrimination risks and CP
  durations; it passes in MATLAB R2026a.
- Documents the required migration from legacy DAQ/audio APIs to MATLAB R2026a.

## V2.1 - Controles De Solo Sonido (`v2.0.0-rc.1`)

- Adds discrimination sound-only trials when risk is greater than zero.
- Adds scheduled sound-only events during dangerous-crossing sessions.
- Adds pure-logic test and simulation scripts; they pass in MATLAB R2026a.
- Fixes a missing return flag found by the first MATLAB execution.

## V1 - Base Limpia R2011a (`v1.0.0`)

- Establecio la copia autocontenida y el menu reducido durante la etapa USB.

## V0 - Archivo Original De La Caja (`v0.1.0`)

- Importa el programa original `fsotres` sin limpieza. Conserva sus dos arboles
  MATLAB porque explican el sombreado historico de funciones.
