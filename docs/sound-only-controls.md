# Sound-Only Controls

This document defines the behavior of `v2.0.0-rc.1`. It is the reference for
review and for any future maintenance.

## Discrimination: `ValentiaE`

- Risk `0`: unchanged safe-crossing behavior; no sound-only event.
- Risk greater than `0`: each ten food-event block gains one sound-only event.
- Example: risk `0.3` becomes seven safe, three food-plus-danger, and one
  sound-only event per block. `300` creates thirty blocks, or 330 events.
- Food-plus-danger and sound-only events are allowed only when the target side
  changes from the preceding event.
- Sound-only lasts 180 seconds even if the rat crosses or presses a lever. It
  gives no food light and no pellet.

## Dangerous Crossings: `ValentiaE2`

- Normal CP behavior remains risk `1` with food/light and danger.
- Sound-only events are due near minutes 9, 18, and 27 after habituation.
- The program checks after a normal ITI and before the next normal CP. It never
  interrupts a trial or ITI; a due event waits for that safe boundary.
- Duration is the GUI field for risk-trial duration: typically 30, 60, 90, or
  120 seconds according to the training day.
- Sound-only uses sound, visible marker, and grid; it has no food light, no
  pellet, and does not end early on crossing or lever press.

## Results

`TipoEvento` is column 9 in the candidate results:

| Value | Meaning |
| --- | --- |
| `0` | Safe trial (discrimination only) |
| `1` | Food-plus-danger/risk trial |
| `2` | Sound-only control |

Run the scripts named in [`../tests/README.md`](../tests/README.md) before a
supervised physical test.
