# Lab Test Plan - Saturday 2026-07-11

## Goal

Validate two separate candidates while someone is physically present at the
box:

1. `main` / `v2.0.0-rc.2` in MATLAB R2011a: sound-only behavioral changes.
2. `migration/r2022a-r2026a-ni-usb6501`: modern hardware/audio candidate.

The remote assistant may inspect logs, edit code, and run non-GUI diagnostics.
The person at the box opens visible GUIs, listens, presses levers, observes
lights/sensors, and decides whether it is safe to proceed.

## Required Connection: Direct Ethernet

Use a direct Ethernet cable between the Mac and `DESKTOP-LAB-S`. This must be
the primary route so the work does not depend on IFC WiFi, DHCP, or Internet
Sharing. Internet Sharing is not required.

Historical direct-link command from the Mac:

```bash
ssh -6 -i ~/.ssh/caja_valentia_lab_ed25519 \
  -o UserKnownHostsFile=/dev/null \
  -o StrictHostKeyChecking=no \
  'alberto@fe80::41ac:7d87:fdfa:563b%en2' hostname
```

Expected output:

```text
DESKTOP-LAB-S
```

Notes:

- `en2` was the Mac USB Ethernet adapter, an AX88179B. Confirm its current
  interface name with `networksetup -listallhardwareports` if the command fails.
- The Windows link-local IPv6 address or Mac interface can change. With someone
  at Windows, run `ipconfig` and use the Ethernet link-local IPv6 address shown
  there, keeping `%en2` (or the current Mac Ethernet interface) in the SSH
  command.
- Historical direct-link IPv4 addresses were Mac `169.254.39.26` and Windows
  `169.254.86.59`, but do not assume they will repeat.
- WiFi SSH is only a fallback. The known direct-link procedure is also recorded
  in the Drive project at `11_operacion_lab/conexion-remota-lab.md`.

## Before Any Box Test

1. No rat in the box for initial hardware tests.
2. Have a physical shutdown/power option available.
3. Confirm SSH by direct cable before opening MATLAB.
4. Do not launch a behavioral GUI directly from SSH. It may be invisible on the
   Windows console. The operator opens MATLAB locally, or use a Windows task
   with `/IT` only when necessary.
5. Record the exact MATLAB path, MATLAB `ver` output, USB path, and test result.

## Phase A: R2011a Baseline

Use the explicit executable:

```text
C:\Program Files (x86)\MATLAB\R2011a\bin\matlab.exe
```

Do not rely on `matlab` from `PATH`; the computer has another MATLAB version.

1. Open the `main` / `v2.0.0-rc.2` USB candidate.
2. Run its non-hardware test suite if present in the copied folder.
3. Open the visible menu with `abrir1`.
4. Check, one at a time: fear conditioning, discrimination, and dangerous
   crossings.
5. Observe GUI defaults, visible state, lever/sensor response, and audio.
6. Stop immediately on unexpected output, wrong side, wrong sound, or an error.

Important: `v2.0.0-rc.2` is a frozen baseline and still has the old 5 kHz GUI
default. The 15 kHz default exists in the modern branch. If the R2011a candidate
must also default to 15 kHz, create a separate `v2.0.0-rc.3` after this baseline
test; do not silently alter the tagged baseline.

## Phase B: Modern MATLAB Candidate

Do not install the current NI driver over the only working R2011a environment
without a disk clone or a separate Windows installation. Prefer the cloned SSD
for this phase.

Required modern installation:

- MATLAB R2022a, R2023a, or newer through R2026a.
- Data Acquisition Toolbox.
- NI-DAQmx hardware support package.
- Windows Sound Cards support package.

Run in this exact order from the modern branch:

```matlab
cmc_prueba_moderno_sin_hardware
cmc_modern_preflight
cmc_modern_audio_preflight
```

The first command runs logic and audio-formula tests. The second detects and
configures the USB-6501 without writing a box output. The third configures
DirectSound at 20 kHz without playing sound.

Only if all three pass, with no animal present:

```matlab
cmc_modern_arm_outputs
```

Then test harmless functions first: LEDs, sensor/lever reads, and audio. Test
dispensers and grid only after the line mapping and shutdown behavior are
confirmed. Close/stop the GUI while outputs are armed, then run:

```matlab
cmc_modern_disarm_outputs
```

Disarming blocks future writes; it does not itself turn an active physical
output off. When in doubt, use the physical shutdown.

## Audio Acceptance Check

The modern branch uses the legacy sample formula at 20 kHz and defaults to
15 kHz in all three task GUIs. It is a random-sample noise rule, not a 5 kHz
tone. Confirm physically:

- the correct speaker or speakers;
- acceptable perceived noise quality;
- comparable level versus R2011a;
- correct onset and duration;
- no clipping, distortion, or unexpected silence.

The code can prove equal numeric samples; only the real Windows audio device and
speakers can prove the sound is acceptable.

## What to Save After Each Phase

- MATLAB version and `ver` output.
- `cmc_modern_preflight` and `cmc_modern_audio_preflight` output.
- Exact error text, if any.
- A short table: task, expected behavior, observed behavior, pass/fail.
- Any code modification made during the session as a separate commit.

## Decision After the Lab

- If R2011a sound-only tests pass: mark the result in documentation; do not yet
  call it final without the agreed behavioral review.
- If modern preflights pass but physical outputs remain untested: create
  `v3.0.0-rc.1` only after recording the result.
- If a test fails: keep the branch, record the failure, fix it remotely, rerun
  the narrow test, and commit the fix. Never overwrite the known working tag.
