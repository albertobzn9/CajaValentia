# CajaValentia

Codigo privado de la caja conductual CMC/Valentia. `main` contiene la version
estable de Discriminacion (`ValentiaE`) validada con MATLAB R2011a y la caja el
12-jul-2026. El codigo historico se conserva para auditoria, no para operar.

## Estado Actual

| Referencia | Uso |
| --- | --- |
| `main` | Fuente activa de Discriminacion. |
| `v2.0.0-rc.4-discriminacion-validada` | Foto inmutable de la version validada: sonido solo, CSV de 10 columnas y contador de ensayos de cruce. |
| `feature/cp-time-aware-sound-only` | Cruces Peligrosos en desarrollo; no esta validada ni fusionada. |
| `legacy/` | Copia original de `fsotres`, solo lectura. |

La historia corta vive en [CHANGELOG.md](CHANGELOG.md). Las etiquetas
`v0.1.0` y `v1.0.0` preservan, respectivamente, el original y la etapa USB;
son antecedentes, no instrucciones de uso actual.

## Leer Primero

1. [Uso diario en la PC del laboratorio](matlab/README_USO_ESCRITORIO.md).
2. [Indice de documentacion](docs/README.md).
3. [Mapa de versiones](docs/version-map.md).
4. [Reglas de seguridad y edicion](AGENTS.md).

## Seguridad

No operar hardware ni probar una version no validada sin una persona entrenada
frente a la caja. No subir a Git resultados de sesion, datos de animales ni
archivos generados. `legacy/` no se limpia ni se modifica.
