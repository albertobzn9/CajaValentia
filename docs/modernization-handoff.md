# Modernization Handoff

## Purpose

This is the short, durable record of why the CajaValentia project has a modern
MATLAB branch, what was verified in software, and what still needs a supervised
lab test. Read this before changing hardware, audio, or MATLAB versions.

## Current Repository State

| Location | Meaning |
| --- | --- |
| `main` / `v2.0.0-rc.2` | Current R2011a candidate: complete USB program with sound-only controls. It remains the reference for the old lab setup. |
| `migration/r2022a-r2026a-ni-usb6501` | Modern candidate for MATLAB R2022a through R2026a. It has not been tested on the physical box. |
| `legacy/` | Untouched historical archive. Never edit it. |

The modern branch is a branch because it changes the hardware and audio layer.
It must not replace the R2011a candidate until it passes physical validation.

## Hardware Facts

- The box uses an NI USB-6501, identified historically as `Dev2`.
- The old program used MATLAB's retired `digitalio('nidaq',...)` interface and
  NI-DAQmx 9.1.
- The USB-6501 is still supported by current MathWorks software for digital I/O.
- The old audio route was `analogoutput('winsound',0)`.

## What the Modern Branch Changes

It keeps behavioral rules and the existing GUIDE GUIs. It replaces only the
old interfaces below:

| Old layer | Modern replacement |
| --- | --- |
| `digitalio`, `addline`, `getvalue`, `putvalue` | `DataAcquisition` API for the NI USB-6501 |
| `analogoutput('winsound')`, `putdata`, `start` | DirectSound through the current Data Acquisition Toolbox |

The modern hardware adapter blocks all box outputs by default. It must be
explicitly armed with `cmc_modern_arm_outputs` during a supervised bench test.
`cmc_modern_preflight` detects/configures the USB-6501 without writing an
output. `cmc_modern_audio_preflight` configures DirectSound at 20 kHz without
playing audio.

## Audio: What Was Actually Found

All three tasks use `OA_Sonidos`:

- Fear conditioning: `OA_Condiciona_Aleatorio`.
- Discrimination: `OA_ValentiaCuatroE`.
- Dangerous crossings: `OA_ValentiaCuatroE2`.

The legacy formula is:

- 20,000 samples per second.
- Frequency at or below 10,000 Hz: sine tone.
- Frequency above 10,000 Hz: random samples, `1.5 * amplitude * rand`.

Therefore, the old default of 5,000 Hz was a tone, despite comments calling it
white noise. The modern branch now sets all three GUI defaults to **15,000 Hz**
through `cmc_frecuencia_ruido_predeterminada`.

Fear conditioning sends the signal to both speakers. Discrimination and CP send
the same signal to the relevant side. That spatial difference is intentional.

The modern test proves that its generated numeric samples exactly match the old
formula. It cannot prove that the speakers sound identical: the old and modern
Windows audio drivers may handle the positive DC offset and values above `1`
differently. Do not silently change the formula to `randn`, normalize it, or
make it zero-centered; that would create a new experimental stimulus.

## What Has Passed

In MATLAB R2026a on the Mac, without hardware:

- Full logic suite for sound-only discrimination and CP.
- Relevant discrimination risks and CP durations.
- Modern safety gate and adapter syntax.
- Exact modern-versus-legacy audio-formula comparison.
- Confirmation that no active MATLAB file in the modern branch calls the old
  DAQ/audio API.

## What Has Not Passed Yet

- MATLAB R2011a test of `v2.0.0-rc.2` on the physical box.
- USB-6501 detection under R2022a/R2023a/R2026a on Windows.
- DirectSound device selection, 20 kHz availability, left/right routing,
  physical level, onset timing, and perceived noise quality.
- Every physical output mapping, including pellet and grid safety.

## Lab Test Order

1. Test `v2.0.0-rc.2` in MATLAB R2011a first, as the old-system baseline.
2. Do not overwrite the working R2011a/NI driver stack. Prefer a cloned SSD or
   separate Windows installation for modern MATLAB.
3. Install MATLAB R2022a-R2026a, Data Acquisition Toolbox, NI-DAQmx support,
   and Windows Sound Cards support.
4. On the modern branch, run `cmc_prueba_moderno_sin_hardware`.
5. Run `cmc_modern_preflight` and `cmc_modern_audio_preflight`; both must pass
   before any output is armed.
6. With no animal present, test harmless LEDs, sensors, and audio before
   dispensers and finally grid behavior.
7. Only after that create/tag `v3.0.0-rc.1`.

## Important Version Note

The 15 kHz default is currently committed on the **modern branch**. The frozen
R2011a candidate `v2.0.0-rc.2` retains its prior default. If the old-system lab
test must also open at 15 kHz, make that a separate small candidate release
rather than silently changing the tagged baseline.

## Supporting Documents

- [`audio-contract.md`](audio-contract.md): audio details and limits.
- [`migration-matlab-2026.md`](migration-matlab-2026.md): migration rationale.
- [`modern-hardware-lab-test.md`](modern-hardware-lab-test.md): lab procedure.
- [`validation.md`](validation.md): tests already run.
- [`lab-test-plan-2026-07-11.md`](lab-test-plan-2026-07-11.md): direct-Ethernet Saturday execution plan.
- [`future-integration-boundary.md`](future-integration-boundary.md): long-term behavior/video/data constraints.
