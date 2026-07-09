# Working Rules

## Non-negotiable

- `legacy/` is an audit archive: do not clean it up or edit it.
- `matlab/` is the runnable package. Preserve its self-contained paths.
- Do not launch a GUI or a hardware output remotely unless a trained person is
  physically present at the box.
- Test pure logic before hardware. State clearly when validation is static only.
- Never commit session results, animal identifiers, or generated `.mat` output.

## Before Editing

Read `docs/README.md`, the relevant decision record, and the test script nearest
to the changed behavior. Keep the complete menu in `abrir1`; experimental
folders must not replace it with a reduced menu.
