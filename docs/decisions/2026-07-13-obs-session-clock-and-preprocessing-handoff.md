# OBS Session Clock And PreProcesamiento Handoff

## Decision

The future **Start** action in CajaValentia will coordinate the behavioral
session and OBS recording as one named session. It must not merely launch both
programs and assume that their clocks match.

The immediate objective is practical: every saved video, behavioral CSV and
later processing report must belong to one explicit session, with a known order
of start events. This removes manual file matching and makes the remaining
video-to-behavior delay measurable instead of mysterious.

This document is both the cross-project contract and the implementation handoff
for the next agent working in this repository.

## Current Verified Situation

- CajaValentia currently starts its behavioral stopwatch with `R0 = tic` in
  `OA_ValentiaCuatroE.m`. Its CSV timestamps use `toc(R0)`.
- OBS is not controlled by the current MATLAB program.
- The current main CSV has **10 columns**, including `ensayo_cruce`; it is not
  the older 9-column CSV described by early Video Batch Processor notes.
- Video and behavioral data currently start independently. A later processor
  therefore has to estimate their relation from lights and event rows.

## Required Start Order

The order below is mandatory for the future integrated Start button:

1. Create a unique `session_id`, session stem and destination folder.
2. Create a small session manifest with status `preparing`.
3. Request OBS to start recording through its supported local control API.
4. Wait for OBS to confirm that recording is actually active. If it fails or
   times out, do **not** start the behavioral task.
5. Record the confirmation timestamp in the manifest.
6. Immediately create `R0`, record the behavioral-clock start timestamp in the
   manifest, and then begin habituation and the behavioral task.

In short: **OBS confirmation first, behavioral `R0` second.** `R0` remains the
authoritative clock for behavioral rows. The manifest makes its relationship to
the recording explicit.

Starting two asynchronous applications from one button does not by itself make
their timestamps frame-perfect. It does create a reliable shared session and a
known causal order, which is the necessary first step.

## Session Manifest V1

The first version should use a flat, UTF-8 `session_manifest_v1.csv` with two
columns, `key,value`. It is deliberately simple enough to write and read in
MATLAB R2011a and .NET without adding a JSON dependency. Keys use dot notation.

Minimum content:

```text
key,value
schema_version,1
session_id,cv-20260713-...
status,recording
session_stem,...
created_utc,...
obs.recording_requested_utc,...
obs.recording_confirmed_utc,...
behavior.clock_name,R0
behavior.clock_started_utc,...
behavior.result_csv,...
behavior.presses_csv,...
video.recording_path,...
```

At the end, update the same manifest with `behavior.task_finished_utc`,
`obs.recording_stopped_utc`, final file paths and `status=completed` or
`status=failed`. Timestamps used to compare computers are UTC wall-clock
timestamps; durations inside the behavioral task continue to be `toc(R0)`.

## End Of Session And Preprocessing

After the task ends:

1. Write the results CSV and optional `_palanqueos.csv`.
2. Request OBS to stop and wait until the final video file is available.
3. Complete the manifest only after all paths are known.
4. Later, invoke Video Batch Processor with the explicit manifest path, not by
   scanning a general folder and guessing which files belong together.

The processor should receive one completed session package: manifest, video,
main behavioral CSV and optional presses CSV. Automatic preprocessing is a
later phase; the current Video Batch Processor does not yet expose that
headless end-to-end command.

## Video Alignment: What This Solves And What It Does Not

This contract prevents identity and start-order ambiguity. It does **not**
claim zero delay between an OBS frame and a MATLAB operation.

For frame-level validation, a later approved test can add a short visual sync
marker that the camera sees and CajaValentia records. It must be tested first
without an animal and must not alter task stimuli or protocol without explicit
laboratory approval. Its role is to measure residual recording latency, not to
replace the behavioral clock.

## Compatibility Gate

Before automatic handoff is enabled, Video Batch Processor must accept the
current CajaValentia main CSV of 10 columns, including `ensayo_cruce`, or have
an explicit compatible adapter. Its current CSV V1 reader expects 9 columns.
Do not silently drop column 10 and do not change the validated CajaValentia
export only to satisfy the processor.

## Implementation Scope For The CajaValentia Agent

Implement in small, reviewable steps:

1. Propose the OBS local-control adapter and error/timeout behavior compatible
   with the laboratory computer.
2. Add manifest creation and updates around the existing Start and final-save
   flow, keeping `R0` as the behavioral clock.
3. Make the task refuse to start when OBS confirmation is absent.
4. Test start, controlled failure, normal stop and final file paths without an
   animal before a supervised short physical session.
5. Report exact timestamps, files produced and remaining limitations.

Do not change task rules, stimulation timing, hardware mappings, CSV semantics
or validated Discriminacion behavior as part of this integration work.

## Related Repositories

- CajaValentia: this repository, especially
  `matlab/OA_ValentiaCuatroE.m` and `matlab/cmc_guardar_resultados_sesion.m`.
- Video Batch Processor:
  `/Users/ab/Documents/GitHub/PreProcesamiento/docs/project/cajavalentia-session-capture-integration.md`.
