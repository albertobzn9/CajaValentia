# Mapa De Versiones

## Version Estable Actual

| Referencia | Uso | Estado |
|---|---|---|
| `main` | Fuente estable para Discriminacion (`ValentiaE`). | Validada con MATLAB R2011a y caja el 12-jul-2026. |
| `v2.0.0-rc.4-discriminacion-validada` | Foto inmutable de la version estable actual. | Incluye CSV de 10 columnas, sonido solo, contador de ensayos de cruce y bitacora. |

Un ensayo de cruce puede ser un cruce lateral real o un no-cruce lateral ante
un cambio de lado. Sonido solo no cuenta. La definicion completa y las pruebas
quedan en [la bitacora](bitacora-lab-2026-07-12-valentiae.md).

## Referencias Historicas

| Referencia | Significado |
|---|---|
| `release/v2.0.0-rc.3-resultados-9-columnas` | Candidato anterior con nueve columnas; conservar solo para comparar o recuperar. |
| `main` antes de `v2.0.0-rc.4-discriminacion-validada` | Base historica previa a la integracion de Discriminacion. |

## Trabajo Que No Esta En Main

| Rama | Contenido | Regla |
|---|---|---|
| `feature/cp-time-aware-sound-only` | Cruces Peligrosos (`ValentiaE2`), sonido solo por tiempo y ajustes CP. | No usar experimentalmente ni fusionar hasta validacion fisica completa. |
| `migration/r2022a-r2026a-ni-usb6501` | Investigacion de migracion a MATLAB moderno. | Separada de la version R2011a que opera la caja. |

El lanzador diario validado es el de la copia `CajaValentia_R2011a_CrucesSensor`
en el Escritorio de la PC del laboratorio. La variante sin privilegios de
administrador sigue pendiente y no forma parte de esta liberacion.
