# Changelog

This changelog records behaviorally meaningful changes. Git commits retain the
lower-level implementation history.

## Unreleased - v2.0.0-rc.3 Candidate

- Records `Tipo evento` as a ninth column in all discrimination and
  dangerous-crossing result rows, including safe-only discrimination sessions.
- Displays the ninth column in both legacy GUIDE result tables and verifies it
  can be saved and loaded without hardware.

## v2.0.0-rc.2 - Software Validation

- Adds one no-hardware suite for the relevant discrimination risks and CP
  durations; it passes in MATLAB R2026a.
- Documents the required migration from legacy DAQ/audio APIs to MATLAB R2026a.

## v2.0.0-rc.1 - Sound-Only Controls

- Adds discrimination sound-only trials when risk is greater than zero.
- Adds scheduled sound-only events during dangerous-crossing sessions.
- Adds pure-logic test and simulation scripts; they pass in MATLAB R2026a.
- Fixes a missing return flag found by the first MATLAB execution.

## v1.0.0 - Portable Core

- Establishes the USB-contained runtime and the reduced daily-use menu.

## v0.1.0 - Legacy Baseline

- Imports the archived original `fsotres` program without cleanup.
