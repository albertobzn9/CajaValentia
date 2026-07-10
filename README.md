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

- [`matlab/README_USO_USB.md`](matlab/README_USO_USB.md): operating from USB.
- [`docs/README.md`](docs/README.md): protocol, hardware, architecture, and decisions.
- [`docs/working-agreement.md`](docs/working-agreement.md): where active work belongs.
- [`HISTORY.md`](HISTORY.md): why the releases exist.
- [`AGENTS.md`](AGENTS.md): safety rules for people and coding agents changing the program.

## Drive Archive

The parallel historical archive is kept read-only at:

```text
/Users/ab/Library/CloudStorage/GoogleDrive-jasjabs19@gmail.com/My Drive/workspace/03_lab/02_CajaValentia
```

It contains earlier MATLAB packages, lab-operation notes, and audit evidence.
Do not edit code there or copy whole folders back into this repository. Review a
specific file, then bring a verified improvement here in a focused commit.

## Scope and Safety

This is a private research repository. The `legacy/` tree is read-only. Do not
operate physical hardware or use an unvalidated version with animals without a
person present at the box. Generated session results are intentionally not
tracked by Git.
