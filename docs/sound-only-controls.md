# Controles De Solo Sonido

> Nota de estado: el contrato conductual de este documento sigue siendo el
> referente conceptual. Sus secciones que describen CSV principal de 10
> columnas o `ensayo_cruce` pertenecen a una rama experimental retirada. Para
> el codigo actual, ver
> [comportamiento actual](current-runtime-behavior-and-known-limitations.md).

Este documento define el contrato conductual de `main` y de la etiqueta
`v2.0.0-rc.4-discriminacion-validada`.

## Discrimination: `ValentiaE`

- Risk `0`: unchanged safe-crossing behavior; no sound-only event.
- The GUI checkbox `Agregar 1 solo sonido / 10 eventos` enables the new mode.
  With the checkbox off, risk sessions use the historical sequence unchanged.
- With the checkbox on and risk greater than `0`, each ten food-event block
  gains one sound-only event.
- Example: risk `0.3` becomes seven safe, three food-plus-danger, and one
  sound-only event per block. `300` creates thirty blocks, or 330 events.
- Food-plus-danger and sound-only events are allowed only when the target side
  changes from the preceding event.
- Sound-only lasts 180 seconds even if the rat crosses or presses a lever. It
  gives no food light and no pellet.

## Dangerous Crossings: `ValentiaE2`

Esta es la especificacion de la rama `feature/cp-time-aware-sound-only`; CP no
forma parte de la version validada en `main` hasta completar prueba fisica.

- Normal CP behavior remains risk `1` with food/light and danger.
- Sound-only events are due near minutes 9, 18, and 27 after habituation.
- The program checks after a normal ITI and before the next normal CP. It never
  interrupts a trial or ITI; a due event waits for that safe boundary.
- Duration is the GUI field for risk-trial duration: typically 30, 60, 90, or
  120 seconds according to the training day.
- Sound-only uses sound, visible marker, and grid; it has no food light, no
  pellet, and does not end early on crossing or lever press.

## Resultados

`tipo_evento` es la columna 9 y `ensayo_cruce` es la columna 10:

| Valor | Significado |
| --- | --- |
| `0` | Safe trial (discrimination only) |
| `1` | Food-plus-danger/risk trial |
| `2` | Sound-only control |

El tipo `2` siempre usa `ensayo_cruce=NA`. Ejecutar la suite indicada en
[`../tests/README.md`](../tests/README.md) antes de una prueba fisica supervisada.
