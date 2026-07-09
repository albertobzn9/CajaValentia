# Modern Hardware Candidate: Lab Test

Branch: `migration/r2022a-r2026a-ni-usb6501`.

This branch targets MATLAB R2022a through R2026a. It replaces the retired DAQ
and `winsound` APIs but does not change behavioral rules, trial sequencing, or
the existing GUIDE GUIs.

## Required Windows Installation

- MATLAB R2022a, R2023a, or newer through R2026a.
- Data Acquisition Toolbox.
- Data Acquisition Toolbox Support Package for NI-DAQmx Devices.
- Data Acquisition Toolbox Support Package for Windows Sound Cards.
- Detected NI USB-6501.

Do not replace the production R2011a/NI driver stack on the only working system
without a disk clone or a separate test Windows installation.

## Safe Test Order

No animal should be in the box. Keep the physical shutdown/power option
available throughout.

1. Open the branch folder in the target MATLAB version.
2. Run `cmc_prueba_moderno_sin_hardware`. This must show `OK`.
3. Run `cmc_modern_preflight`.
   It detects and configures the NI USB-6501 but does **not** write an output.
   Expected result: `OK preflight: Dev2 (USB-6501)`.
4. Run `cmc_modern_audio_preflight`.
   It configures a 20 kHz DirectSound output but does **not** play audio.
5. Save the full MATLAB output and stop. This is the first decision point.
6. Only with a trained person at the box, run `cmc_modern_arm_outputs` and test
   harmless outputs first: LEDs, then sensors, then dispensers. Test grid and
   audio only after their line mappings and shutdown behavior are verified.

## Safety Gate

Physical output is blocked by default. `cmc_modern_arm_outputs` is intentionally
required in each MATLAB session before any GUI can write to the USB-6501.

`cmc_modern_disarm_outputs` blocks future writes; it does not itself send a
shutdown command. Stop/close the GUI while outputs are armed, then disarm.
When in doubt, use the physical power shutdown.

## What This Does Not Validate

- Exact timing of audio onset.
- Actual level, spectrum, and perceived quality of the 15 kHz noise signal.
- Physical output polarity or box wiring.
- Safety of grid activation.
- Correct response from a real rat.

Those require supervised bench testing against the existing R2011a version.
