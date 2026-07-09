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

## Pending

- Confirm compatibility in MATLAB R2011a on the lab computer.
- Check all GUI paths and physical hardware outputs with a trained operator
  present.
- Confirm generated result columns and timestamps from a real session.

Until these steps pass, `v2.0.0-rc.2` is a candidate, not a production release.

## Modern Hardware Branch

The branch `migration/r2022a-r2026a-ni-usb6501` passes its software-only test
in MATLAB R2026a. It has not yet run `cmc_modern_preflight` on a Windows machine
with Data Acquisition Toolbox, NI support, and the USB-6501 attached.
