# Working Rules

## Non-negotiable

- `legacy/` is an audit archive: do not clean it up or edit it.
- `matlab/` is the runnable package. Preserve its self-contained paths.
- Do not launch a GUI or a hardware output remotely unless a trained person is
  physically present at the box.
- Test pure logic before hardware. State clearly when validation is static only.
- Never commit session results, animal identifiers, or generated `.mat` output.

## Behavioral Semantics

- Result type `0`: safe trial.
- Result type `1`: food-plus-danger/risk trial.
- Result type `2`: sound-only control.
- In discrimination, sound-only is enabled only when risk is greater than zero
  and only on a side change. It lasts 180 seconds and gives no food/pellet.
- In dangerous crossings, sound-only is time-scheduled and runs only at a safe
  boundary between normal trials; it gives no food/pellet.

## Before Editing

Read `docs/README.md`, the relevant decision record, and the test script nearest
to the changed behavior. Keep the complete menu in `abrir1`; experimental
folders must not replace it with a reduced menu.
