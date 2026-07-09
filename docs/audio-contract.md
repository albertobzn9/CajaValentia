# Audio Contract

The same function, `OA_Sonidos`, is used by fear conditioning
(`OA_Condiciona_Aleatorio`), discrimination (`OA_ValentiaCuatroE`), and dangerous
crossings (`OA_ValentiaCuatroE2`). The modern branch preserves its sample
generation formula exactly.

## Actual Legacy Rule

- Sample rate: 20,000 Hz.
- Frequency at or below 10,000 Hz: sine tone.
- Frequency above 10,000 Hz: random-sample noise at `1.5 * amplitude`.
- The shared default in all three active GUIs is 15,000 Hz. It is set by
  `cmc_frecuencia_ruido_predeterminada`, so opening a GUI no longer resets the
  experiment to a 5 kHz tone.

## Same Signal, Different Location

Fear conditioning sends the signal to both channels. Discrimination and
dangerous crossings send the same waveform to the target side only. This is an
intentional spatial difference, not a different sound generator.

## Modern Branch

The modern branch uses current DirectSound support rather than `winsound` or
`audioplayer`. It keeps the 20 kHz sample rate and exact sample formula. Run
`cmc_prueba_compatibilidad_audio` to compare formulas without sound hardware.

No software-only test can prove that two speakers sound identical. The lab test
must confirm output device, level, left/right routing, onset timing, and the
actual intended frequency. `cmc_modern_audio_preflight` configures DirectSound
at 20 kHz but does not play audio.
