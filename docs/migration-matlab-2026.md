# Migration to Modern MATLAB

## Conclusion

The behavioral logic can migrate. The current program cannot run unchanged in
R2022a-R2026a because its hardware layer uses the retired legacy DAQ interface.
Migration is feasible because the recorded hardware is an NI USB-6501, which
MathWorks currently lists as supported for digital I/O.

## What the Current Program Uses

| Current code | Purpose | Migration status |
| --- | --- | --- |
| `digitalio('nidaq','Dev2')` and `addline` | NI USB-6501 digital inputs/outputs | Must move to the current NI `daq`/`DataAcquisition` API. |
| `getvalue` and `putvalue` | Read sensors and set box outputs | Must be adapted to current digital I/O calls. |
| `daqreset` | Reset legacy DAQ objects | Must be removed/replaced by explicit cleanup. |
| `analogoutput('winsound')` and `addchannel` | Stereo sound | Must move to a current audio-output implementation and be timing-tested. |

The mapping of the 24 USB-6501 lines is documented in
[`hardware-io.md`](hardware-io.md). The old `Dev2` name is only a local MATLAB
identifier, not the hardware model.

## What We Know

- Historical diagnostic records identify `Dev2` as an NI USB-6501.
- The old diagnostic used NI-DAQmx 9.1.
- MATLAB R2026a on this Mac currently has only base MATLAB installed; it does
  not include Data Acquisition Toolbox or the NI support package.
- The NI USB-6501 remains listed by MathWorks as current-supported for digital
  input/output. This is encouraging, but it is not yet a lab-machine test.

## Safe Migration Plan

1. Keep MATLAB R2011a in production until the new version passes all checks.
2. On a separate Windows computer, install MATLAB R2022a or newer through
   R2026a, Data Acquisition
   Toolbox, and the NI-DAQmx support package.
3. Build a small hardware adapter that first reproduces only the existing 24
   digital lines. Verify every input and output with the box disconnected from
   animals.
4. Migrate audio separately and measure left/right sound timing.
5. Connect the unchanged behavioral logic to the new adapter, then compare a
   supervised mock session against R2011a before any animal session.

## R2011a Installer on This Mac

`R2011a_UNIX.iso` contains Intel Mac and Linux installers. It is useful as an
archive and possibly for inspecting old behavior, but it is not a reliable test
environment for the current Apple-silicon Mac and macOS. The lab's actual
Windows release and its installed toolbox/driver remain the reference for
backward-compatibility testing.

## Current Migration Branch

`migration/r2022a-r2026a-ni-usb6501` contains the first modern adapter. It uses
the `DataAcquisition` API introduced in R2020a, so it intentionally avoids APIs
added after R2022a. Its test protocol is
[`modern-hardware-lab-test.md`](modern-hardware-lab-test.md).
