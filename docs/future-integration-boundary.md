# Future Integration Boundary

## Strategic Context

The long-term goal is a coordinated system for behavioral control, video, and
data. This repository remains responsible only for the behavioral-box side.

Canonical planning source:

```text
/Users/ab/Library/CloudStorage/GoogleDrive-jasjabs19@gmail.com/My Drive/workspace/02_gestion/03_planeacion/18_BIG_PICTURE_INTEGRACION_CONDUCTA_VIDEO_DATOS.md
```

That planning document is the source of truth for cross-project priorities.
This note preserves the parts that must guide future CajaValentia decisions.

## Future Desired Behavior

In a later semester, one orchestrator should validate the session, create a
unique `session_id`, start/stop behavioral control and video recording, and
leave a structured session record linking events, video, `.mat` files, and
metadata.

## Design Rules for CajaValentia Now

- Keep behavioral rules, hardware control, video capture, storage, and clip
  analysis as separate modules.
- Preserve or make it possible to emit: `session_id`, subject, phase, operator,
  parameters, start/end times, abort state, and relevant event timestamps.
- Distinguish at least: video start, habituation start, MATLAB event start,
  LED/light onset, event end, and session end.
- Prefer explicit metadata/manifests over reconstructing identity from file
  names.
- Keep timestamps traceable to their source and document their meaning.

## Explicitly Out of Scope Today

- No runtime dependency between CajaValentia and PreProcesamiento.
- No automatic video control from this MATLAB program yet.
- No production database or rushed full rewrite for the sake of integration.
- No change to hardware-safety priorities while the R2011a and modern MATLAB
  candidates remain under validation.

## When to Revisit

Revisit this boundary only after CajaValentia has a validated behavioral/hardware
version and PreProcesamiento can process one session with a reviewable output.
At that point, agree on a shared session-manifest contract before building an
orchestrator.
