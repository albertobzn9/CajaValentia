# CajaValentia

Private research software archive for the CMC/Valentia behavioral box. This
repository makes the evolution of the MATLAB program explicit while preserving
the historical program needed to understand old data and behavior.

## Releases

| Tag | Name | Meaning |
| --- | --- | --- |
| `v0.1.0` | Legacy Baseline | Untouched `fsotres` runtime snapshot, including both MATLAB code trees that were present on the lab computer. |
| `v1.0.0` | Portable Core | Self-contained USB package with the daily-use MATLAB menu and its required dependencies. |
| `v2.0.0-rc.1` | Sound-Only Controls | Candidate that adds sound-only controls to discrimination and dangerous crossings. Hardware validation is still required. |
| `v2.0.0-rc.2` | Software Validation | Candidate with an expanded no-hardware test suite and a documented R2026a migration path. |

## Read First

- [`matlab/README_USO_ESCRITORIO.md`](matlab/README_USO_ESCRITORIO.md): daily operation from the lab Desktop.
- [`docs/README.md`](docs/README.md): protocol, hardware, architecture, and decisions.
- [`HISTORY.md`](HISTORY.md): why the releases exist.
- [`AGENTS.md`](AGENTS.md): safety rules for people and coding agents changing the program.

## Daily Lab Deployment

The active laboratory copy is deployed at:

```text
C:\Users\Alberto\Desktop\CajaValentia
```

Open `Abrir_CajaValentia_R2011a.bat` from that folder with a normal user
double-click. It starts MATLAB R2011a and the cleaned menu without using USB or
administrator elevation. The GitHub repository remains the source of truth;
the Desktop copy is the validated runtime.

## Scope and Safety

This is a private research repository. The `legacy/` tree is read-only. Do not
operate physical hardware or use an unvalidated version with animals without a
person present at the box. Generated session results are intentionally not
tracked by Git.
