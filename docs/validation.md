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

## Pending

- Confirm compatibility in MATLAB R2011a on the lab computer.
- Check all GUI paths and physical hardware outputs with a trained operator
  present.
- Confirm generated result columns and timestamps from a real session.

Until these steps pass, `v2.0.0-rc.1` is a candidate, not a production release.
