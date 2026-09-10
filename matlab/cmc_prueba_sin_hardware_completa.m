function cmc_prueba_sin_hardware_completa
%CMC_PRUEBA_SIN_HARDWARE_COMPLETA Verifica la logica v2 sin DAQ, audio ni GUI.

cmc_setup_paths();
raizProyecto = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(raizProyecto,'tests','problema_1_conteo_ensayos_cruce'));
addpath(fullfile(raizProyecto,'tests','problema_focos_comida'));
cmc_prueba_discriminacion(0);
cmc_prueba_discriminacion(0.1);
cmc_prueba_discriminacion(0.15);
cmc_prueba_discriminacion(0.2);
cmc_prueba_discriminacion(0.3);
cmc_prueba_discriminacion(0.6);
cmc_prueba_modo_historico_sin_sonido;
cmc_prueba_conteo_ensayos_cruce;
cmc_prueba_temporizacion_estimulos;

DuracionesCP = [30 60 90 120];
for k = 1:length(DuracionesCP)
    Texto = evalc('cmc_simulacion_cp_sonido_solo(DuracionesCP(k));');
    assert(~isempty(strfind(Texto,'OK CP:')), ...
        'La simulacion CP no termino correctamente.');
end

disp('OK: suite completa sin hardware aprobada.');
end


function cmc_prueba_discriminacion(Riesgo)
[Secuencia,Modo] = OA_SecuenciaDiscriminacionSonidoSolo(300,3,Riesgo);

if Riesgo == 0
    assert(Modo == 0, 'Riesgo 0 debe mantener el modo historico.');
    assert(size(Secuencia,1) == 1000, 'Riesgo 0 debe conservar 1000 eventos.');
    assert(all(Secuencia(:,2) == 0), 'Riesgo 0 no debe incluir riesgo ni sonido solo.');
    return
end

NumRiesgo = round(Riesgo * 10);
assert(Modo == 1, 'Riesgo positivo debe activar sonido solo.');
assert(Secuencia(1,2) == 0, 'El primer evento debe ser seguro.');
assert(cmc_cuenta_ensayos_cruce_programados(Secuencia) == 300, ...
    'La secuencia debe contener 300 ensayos programados de cruce.');
assert(sum(Secuencia(:,2) == 2) == 30, ...
    'Debe existir un sonido solo por cada diez ensayos de cruce.');

TiposCruce = cmc_tipos_cruce_programados(Secuencia);
for Bloque = 1:30
    Inicio = (Bloque - 1) * 10 + 1;
    Tipos = TiposCruce(Inicio:Inicio + 9);
    assert(sum(Tipos == 0) == 10 - NumRiesgo, 'Numero incorrecto de seguros.');
    assert(sum(Tipos == 1) == NumRiesgo, 'Numero incorrecto de riesgos.');
end

for i = 2:size(Secuencia,1)
    if Secuencia(i,2) > 0
        assert(Secuencia(i,1) ~= Secuencia(i-1,1), ...
            'Riesgo o sonido solo aparecio sin cambio de lado.');
    end
end
end


function cmc_prueba_modo_historico_sin_sonido
evalc('[Secuencia,Modo] = OA_SecuenciaDiscriminacionSonidoSolo(300,3,0.3,0);');
assert(Modo == 0, 'La casilla apagada debe conservar el modo historico.');
assert(size(Secuencia,1) == 1000, 'El modo historico debe preparar 1000 eventos.');
assert(all(Secuencia(:,2) == 0 | Secuencia(:,2) == 1), ...
    'El modo historico no debe incluir eventos de sonido solo.');
assert(Secuencia(1,2) == 0, 'El primer evento historico debe ser seguro.');
end


function tipos = cmc_tipos_cruce_programados(Secuencia)
tipos = [];
for i = 1:size(Secuencia,1)
    mismoLado = i > 1 && Secuencia(i-1,1) == Secuencia(i,1);
    if cmc_es_ensayo_cruce_programado(mismoLado,Secuencia(i,2))
        tipos = [tipos Secuencia(i,2)]; %#ok<AGROW>
    end
end
end
