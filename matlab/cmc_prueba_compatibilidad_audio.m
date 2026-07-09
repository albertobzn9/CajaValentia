function cmc_prueba_compatibilidad_audio
%CMC_PRUEBA_COMPATIBILIDAD_AUDIO Compara muestras modernas con la formula vieja.

cmc_setup_paths();
Casos = [5000 1 0 0; 0 0 5000 1; 15000 1 0 0; 0 0 15000 1; 15000 1 15000 1];
assert(cmc_frecuencia_ruido_predeterminada == 15000, ...
    'La frecuencia predeterminada de ruido debe ser 15000 Hz.');

for k = 1:size(Casos,1)
    fI = Casos(k,1);
    AI = Casos(k,2);
    fD = Casos(k,3);
    AD = Casos(k,4);
    rng(17,'twister');
    Esperado = cmc_formula_sonido_vieja(0.1,fI,AI,fD,AD);
    rng(17,'twister');
    Actual = CMCGeneraSonido(0.1,fI,AI,fD,AD,1.5);
    assert(isequal(Esperado,Actual), ...
        'La formula moderna no coincide con la generacion legacy.');
end

disp(['OK audio: las muestras modernas son identicas a la formula legacy. ' ...
    'El predeterminado compartido es ruido aleatorio de 15000 Hz.']);


function Samples = cmc_formula_sonido_vieja(Duracion,fI,AI,fD,AD)
fm = 20000;
t = (0:1/fm:Duracion)';
if fI <= 10000
    sI = AI*sin(2*pi*fI*t);
else
    sI = 1.5*AI*rand(length(t),1);
end
if fD <= 10000
    sD = AD*sin(2*pi*fD*t);
else
    sD = 1.5*AD*rand(length(t),1);
end
Samples = [sI sD];
