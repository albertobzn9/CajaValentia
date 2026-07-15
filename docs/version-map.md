# Mapa De Versiones

> Estado actual: `main` corresponde a la base restaurada con reloj de
> habituacion y aviso LED final. Las entradas que describen CSV de 10 columnas,
> `ensayo_cruce` o limites nuevos de mismo lado son historia de ramas
> experimentales, no el runtime actual. Ver
> [comportamiento actual](current-runtime-behavior-and-known-limitations.md).

Una version tiene dos nombres: una etiqueta tecnica de Git y un nombre humano.
Las etiquetas existentes no se renombran: son referencias historicas. Este
documento es la fuente unica para saber que significa cada una.

## Historia Confirmada

| Etapa | Nombre humano | Referencia Git | Significado |
| --- | --- | --- | --- |
| V0 | **Archivo Original de la Caja** | `v0.1.0` | Captura sin limpiar de `fsotres`; incluye duplicados, variantes y menus viejos. Solo auditoria. |
| V1 | **Base Limpia R2011a** | `v1.0.0` | Runtime autocontenido depurado, sin las iteraciones pasadas. Es la base de trabajo entregada a Eric. |
| V2.1 | **Controles de Solo Sonido** | `v2.0.0-rc.1` | Primera integracion de sonido solo en Discriminacion y CP. |
| V2.2 | **Validacion de Software** | `v2.0.0-rc.2` | Simulaciones sin hardware y linea de migracion moderna. |
| V2.3 | **Resultados con Tipo de Evento** | `v2.0.0-rc.3-resultados-9-columnas` | Punto historico de columna 9 y resultados previos. |
| V2.4 | **Discriminacion Experimental Validada** | `v2.0.0-rc.4-discriminacion-validada` | Foto historica: sonido solo, CSV de 10 columnas y contador de ensayos de cruce. No es `main`. |
| Actual | **Base R2011a Restaurada** | `main` | Base funcional previa a esos cambios, con reloj de habituacion y aviso LED final. |

## Etapas Planeadas

| Etapa | Nombre humano reservado | Cuando existe |
| --- | --- | --- |
| V2 final | **Conducta Extendida R2011a** | Cuando Cruces Peligrosos pase validacion fisica e integre a `main`. |
| V3 | **Interfaz GUIDE Unificada** | Cuando la nueva GUI de Eric sea equivalente y validada contra V2. |
| V4 | **Runtime Moderno** | Cuando la reescritura en tecnologia moderna controle la caja con equivalencia validada. |

## Estado Actual

- `main` usa la **Base de Restauracion R2011a**: la base funcional previa a
  cambios de logica de eventos, con solo reloj de habituacion y aviso LED
  final. La decision y el alcance exacto estan en
  [`decisions/2026-07-15-restauracion-base-valentiae.md`](decisions/2026-07-15-restauracion-base-valentiae.md).
- `v2.0.0-rc.4-discriminacion-validada` permanece como evidencia historica; no
  debe confundirse con el runtime restaurado.
- `feature/cp-time-aware-sound-only` es trabajo de V2 final, no una version
  liberada ni apta para uso experimental.
- `migration/r2022a-r2026a-ni-usb6501` es investigacion para V4.
- V1 sigue disponible como base inmutable; no se debe reconstruir desde V0.

El lanzador diario validado permanece en
`C:\Users\Alberto\Desktop\CajaValentia_R2011a_CrucesSensor`. La variante sin
administrador sigue pendiente y no forma parte de V2.4.
