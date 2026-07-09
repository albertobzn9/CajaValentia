function cmc_prueba_moderno_sin_hardware
%CMC_PRUEBA_MODERNO_SIN_HARDWARE Prueba logica compatible R2022a-R2026a.

cmc_setup_paths();
cmc_prueba_sin_hardware_completa();

Tono = CMCGeneraSonido(1,1000,1,0,0,1.5);
Ruido = CMCGeneraSonido(1,12000,1,12000,1,1.5);
assert(size(Tono,2) == 2 && size(Ruido,2) == 2, ...
    'El audio moderno debe ser estereo.');
assert(size(Tono,1) == 20001 && size(Ruido,1) == 20001, ...
    'El audio moderno debe conservar la frecuencia de 20 kHz.');
assert(all(isfinite(Tono(:))) && all(isfinite(Ruido(:))), ...
    'El audio moderno produjo valores no validos.');

cmc_modern_disarm_outputs();
disp('OK: logica moderna aprobada sin tarjeta, audio ni GUI.');
