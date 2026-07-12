# Validation Status

## Completed

- Static source review of the integrated MATLAB changes.
- Pure-logic test and simulation scripts included for discrimination and
  dangerous crossings.
- Executed successfully in MATLAB R2026a on macOS: discrimination tests for
  risk `0`, `0.1`, and `0.3`; one discrimination simulation; CP schedule test;
  and a CP simulation with 30-second duration.
- The first MATLAB run exposed a missing `ModoSonidoSolo` return value in the
  discrimination sequence helper. It was fixed, then the full non-hardware
  suite was rerun successfully.
- The expanded full suite was executed successfully in MATLAB R2026a. It covers
  risk `0`, `0.1`, `0.15`, `0.2`, `0.3`, and `0.6`, plus CP durations 30, 60,
  90, and 120 seconds.
- On 2026-07-11, the lab computer ran the supervised R2011a stereo diagnostic
  successfully. It resolved `OA_Sonidos.m` and `OA_PreparaSonidos.m` from the
  isolated Desktop candidate, and the operator confirmed left-only then
  right-only output. The audio path is not a bilateral-output bug.
- On the same computer, the supervised 10-second sound-only diagnostic passed
  for both requested sides. It produced noise, threat LED, and grid, without
  food light or pellet; its result artifact and logs were saved automatically.
- The R2011a `ValentiaE` session-stop controls were supervised successfully.
  `Detener ahora` kept completed rows without adding a false timeout for the
  interrupted event. `Detener tras ensayo` let the current trial reward and
  register its final row, then prevented the next event.
- The no-hardware suite confirms the new sound-only checkbox: checked uses the
  extra type-2 event per ten food events; unchecked uses the historical risk
  sequence with no type-2 events.

## Pending

- Confirm the Desktop launcher opens MATLAB R2011a as user Alberto without a
  UAC administrator prompt.
- Check all GUI paths and physical hardware outputs with a trained operator
  present.
- Confirm the two checkbox states in the R2011a GUI after deployment.
- Confirm generated result columns and timestamps from a real session.

Until these steps pass, `v2.0.0-rc.1` is a candidate, not a production release.
