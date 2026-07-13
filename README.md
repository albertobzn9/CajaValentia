# CajaValentia

Codigo privado de la caja conductual CMC/Valentia. `main` contiene la version
estable de Discriminacion (`ValentiaE`) validada con MATLAB R2011a y la caja el
12-jul-2026. El codigo historico se conserva para auditoria, no para operar.

## Estado Actual

| Referencia | Uso |
| --- | --- |
| `main` | **V2.4 - Discriminacion Validada**, fuente activa de Discriminacion. |
| `v2.0.0-rc.4-discriminacion-validada` | Foto inmutable de V2.4: sonido solo, CSV de 10 columnas y contador de ensayos de cruce. |
| `feature/cp-time-aware-sound-only` | Cruces Peligrosos en desarrollo; no esta validada ni fusionada. |
| `legacy/` | Copia original de `fsotres`, solo lectura. |

La historia y los nombres oficiales viven en [docs/version-map.md](docs/version-map.md).
V0 es el original; V1 es la base limpia R2011a; V2.4 es la version estable
actual. Ninguna de las versiones antiguas es una instruccion de uso diario.

## Leer Primero

1. [Uso diario en la PC del laboratorio](matlab/README_USO_ESCRITORIO.md).
2. [Indice de documentacion](docs/README.md).
3. [Mapa de versiones](docs/version-map.md).
4. [Reglas de seguridad y edicion](AGENTS.md).
5. [Handoff para rediseño GUIDE](handoff/eric-gui-redesign/README.md).

## Seguridad

No operar hardware ni probar una version no validada sin una persona entrenada
frente a la caja. No subir a Git resultados de sesion, datos de animales ni
archivos generados. `legacy/` no se limpia ni se modifica.
