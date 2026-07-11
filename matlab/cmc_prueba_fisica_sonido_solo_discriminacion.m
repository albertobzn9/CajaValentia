function cmc_prueba_fisica_sonido_solo_discriminacion
%CMC_PRUEBA_FISICA_SONIDO_SOLO_DISCRIMINACION Verifica una vez la salida tipo 2.
% Esta prueba dura 10 s, no enciende luz de comida ni entrega pellet.
% La parrilla se activa: ejecutar solo con la caja vacia y el operador presente.

cmc_setup_paths();
duracion = 10;
archivoLog = fullfile(cmc_results_dir(), 'prueba_sonido_solo_discriminacion.txt');
if exist(archivoLog, 'file')
    delete(archivoLog);
end
diary(archivoLog);
limpiaLog = onCleanup(@() diary('off'));
fprintf('Inicio de prueba fisica de sonido solo.\n');
fprintf('OA_Sonidos: %s\n', which('OA_Sonidos'));
fprintf('OA_PreparaSonidos: %s\n', which('OA_PreparaSonidos'));
fprintf('OA_ValentiaInicio: %s\n', which('OA_ValentiaInicio'));

respuesta = questdlg([ ...
    'Prueba fisica de sonido solo: activara ruido, LED de amenaza y parrilla ', ...
    'durante 10 s. No habra luz de comida ni pellet. Confirma que la caja esta vacia.'], ...
    'CajaValentia - prueba de sonido solo', 'Ejecutar', 'Cancelar', 'Cancelar');
if ~strcmp(respuesta, 'Ejecutar')
    disp('Prueba cancelada.');
    return
end

lado = questdlg('En que bocina se debe reproducir el ruido?', ...
    'CajaValentia - lado de audio', 'Izquierda', 'Derecha', 'Izquierda');
if isempty(lado)
    disp('Prueba cancelada.');
    return
end

OA = [];
GS = [];
try
    daqreset
    GS = OA_PreparaSonidos;
    OA = OA_ValentiaInicio;
    cmc_apaga_estimulos_prueba(OA, GS);

    frecuencia = cmc_frecuencia_ruido_predeterminada;
    R0 = tic;
    if strcmp(lado, 'Izquierda')
        OA_Sonidos(GS, duracion + 1, frecuencia, 1, 0, 0);
    else
        OA_Sonidos(GS, duracion + 1, 0, 0, frecuencia, 1);
    end

    pause(.1);
    OA_ValentiaEstimuloD(OA, 2, 0);
    pause(.1);
    OA_ValentiaElectrico(OA, 1);
    fprintf('Prueba activa: ruido + LED + parrilla, sin luz de comida.\n');
    pause(duracion);

    % Misma forma de nueve columnas que un evento real tipo 2.
    ResultadosPrueba = [1 -2 1 duracion toc(R0) 0 0 duracion 2];
    assert(size(ResultadosPrueba, 2) == 9, ...
        'La prueba debe registrar nueve columnas.');
    save(fullfile(cmc_results_dir(), 'prueba_sonido_solo_discriminacion.mat'), ...
        'ResultadosPrueba', 'lado', 'frecuencia');

    cmc_apaga_estimulos_prueba(OA, GS);
    fprintf('OK: prueba terminada sin luz de comida ni pellet.\n');
    msgbox('OK: termino la prueba. Revise que no hubo luz de comida ni pellet.', ...
        'CajaValentia');
catch ME
    cmc_apaga_estimulos_prueba(OA, GS);
    cmc_registra_error_prueba(ME);
    rethrow(ME)
end


function cmc_apaga_estimulos_prueba(OA, GS)
if ~isempty(OA)
    try
        OA_ValentiaElectrico(OA, 0);
        OA_ValentiaEstimuloI(OA, 0, 0);
        OA_ValentiaEstimuloD(OA, 0, 0);
    catch
    end
end
if ~isempty(GS)
    try
        stop(GS);
    catch
    end
end


function cmc_registra_error_prueba(ME)
fprintf('ERROR [%s]: %s\n', ME.identifier, ME.message);
for k = 1:length(ME.stack)
    fprintf('  en %s (linea %d)\n', ME.stack(k).name, ME.stack(k).line);
end
