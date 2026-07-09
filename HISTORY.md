# Project History

This is a curated technical history created in 2026. It does not claim to
reconstruct every historical edit of the original MATLAB folders.

## v0.1.0 - Legacy Baseline

Preserves the `fsotres` Windows snapshot exactly as archived. It has two MATLAB
trees because both were present in the original runtime path. Keeping both
explains old function shadowing and is essential for audit/reproducibility.

## v1.0.0 - Portable Core

Extracts the daily-use program and its dependencies into a self-contained USB
folder. `abrir1` is the supported entry point; the local `abrir` wrapper avoids
accidentally resolving an older global menu.

## v2.0.0-rc.1 - Sound-Only Controls

Integrates sound-only control events into both discrimination (`ValentiaE`) and
dangerous crossings (`ValentiaE2`). It is a release candidate until MATLAB and
physical-box checks are completed.
