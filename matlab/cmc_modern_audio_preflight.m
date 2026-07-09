function Info = cmc_modern_audio_preflight
%CMC_MODERN_AUDIO_PREFLIGHT Configura DirectSound sin reproducir sonido.

cmc_setup_paths();
Audio = CMCAudio(20000); %#ok<NASGU>
Info = struct('DeviceID',Audio.DeviceID,'SampleRate',Audio.SampleRate);
fprintf('OK audio preflight: %s a %d Hz. No se reprodujo sonido.\n', ...
    Info.DeviceID,Info.SampleRate);
