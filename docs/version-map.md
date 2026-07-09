# Version Map

This page explains the project history without requiring Git knowledge.

## Three Git Words

| Word | Plain meaning | CajaValentia example |
| --- | --- | --- |
| Commit | A saved, dated change with a short explanation. | “Add guarded NI USB-6501 adapter.” |
| Branch | A separate work line. It protects the working version while an experiment is built. | `migration/r2022a-r2026a-ni-usb6501` |
| Tag | A permanent name attached to one important commit. It marks a version that can always be recovered. | `v2.0.0-rc.2` |

A tag does not contain separate code. It is a durable label pointing to the
exact commit that contains that version.

## Version History

```text
v0.1.0  Legacy Baseline
  |
v1.0.0  Portable Core
  |
v2.0.0-rc.1  Sound-Only Controls
  |
v2.0.0-rc.2  Software Validation  <--- main (stable reference)
  |
  +-- migration/r2022a-r2026a-ni-usb6501  <--- modern work branch
        |
        +-- NI USB-6501 adapter
        +-- 15 kHz audio default and DirectSound adapter
        +-- documentation and lab test protocol
```

### v0.1.0 - Legacy Baseline

Exact archived `fsotres` program, including the historical folder structure.
It is kept so old behavior and data can be audited. Do not edit it.

### v1.0.0 - Portable Core

The functional, self-contained USB package. It contains the normal daily-use
menu and only the needed program dependencies.

### v2.0.0-rc.1 - Sound-Only Controls

Adds sound-only controls to discrimination and dangerous crossings.

### v2.0.0-rc.2 - Software Validation

Adds and passes the no-hardware MATLAB R2026a test suite. This is the current
reference on `main` for the R2011a candidate. It is still not final because
hardware validation is pending.

## What “RC” Means

`RC` means **release candidate**: a version believed ready for testing, but not
yet approved as the final production version.

- `rc.1`: first candidate with sound-only controls.
- `rc.2`: same candidate plus broader software tests.

When R2011a and physical-box checks pass, the next approved version can receive
a final tag such as `v2.0.0`. Until then, keep the `rc` name: it is an honest
warning that real hardware testing remains.

## Why the Modern Branch Exists

The old R2011a program uses retired hardware and audio interfaces. The modern
branch replaces those interfaces while keeping the behavioral logic and GUIs.
It targets MATLAB R2022a through R2026a.

It is separate because it must not endanger the R2011a program that currently
runs the box. When its Windows/USB-6501/DirectSound tests pass, it can be tagged
`v3.0.0-rc.1`. After full approval, it can become `v3.0.0`.

## Is Everything on GitHub?

Yes. Both branches and all version tags are pushed to this private repository:

<https://github.com/albertobzn9/CajaValentia>

The repository is private. A link alone is not enough for a lab colleague to
view it. Invite them in GitHub as a repository collaborator, then they can read
the code, history, tags, releases, and documents. They should not work directly
on `main`; comments, issues, or a separate branch are safer ways to contribute.

## Practical Rule

- Want the known R2011a candidate? Start from `main` / `v2.0.0-rc.2`.
- Want to work on current MATLAB? Start from the modern migration branch.
- Want to preserve an important testable state forever? Create an annotated tag.
- Want to save a normal piece of work? Make a commit.
