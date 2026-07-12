function cmc_prueba_audio_estereo
%CMC_PRUEBA_AUDIO_ESTEREO Prueba canal izquierdo y derecho sin caja ni NI.

cmc_setup_paths();
duracion = 2;
frecuencia = cmc_frecuencia_ruido_predeterminada;
archivoLog = fullfile(cmc_results_dir(), 'prueba_audio_estereo.txt');
archivoDatos = fullfile(cmc_results_dir(), 'prueba_audio_estereo.mat');
if exist(archivoLog, 'file')
    delete(archivoLog);
end
diary(archivoLog);
limpiaLog = onCleanup(@() diary('off'));
fprintf('Inicio de prueba de audio estereo.\n');
fprintf('OA_Sonidos: %s\n', which('OA_Sonidos'));
fprintf('OA_PreparaSonidos: %s\n', which('OA_PreparaSonidos'));

inicio = questdlg([ ...
    'Se reproducira ruido durante 2 s por la izquierda y despues 2 s por ', ...
    'la derecha. No activa la caja.'], ...
    'CajaValentia - prueba de audio', 'Iniciar', 'Cancelar', 'Cancelar');
if ~strcmp(inicio, 'Iniciar')
    disp('Prueba de audio cancelada.');
    return
end

GS = [];
try
    GS = OA_PreparaSonidos;

    disp('Canal izquierdo activo.');
    OA_Sonidos(GS, duracion, frecuencia, 1, 0, 0);
    pause(duracion + .5);
    stop(GS);
    respuestaIzq = questdlg('Durante el primer pulso, que se escucho?', ...
        'Canal izquierdo', 'Solo izquierda', 'Ambos lados', 'Nada', 'Nada');

    disp('Canal derecho activo.');
    OA_Sonidos(GS, duracion, 0, 0, frecuencia, 1);
    pause(duracion + .5);
    stop(GS);
    respuestaDer = questdlg('Durante el segundo pulso, que se escucho?', ...
        'Canal derecho', 'Solo derecha', 'Ambos lados', 'Nada', 'Nada');

    ResultadosAudio = struct('frecuencia', frecuencia, 'duracion', duracion, ...
        'respuestaIzquierda', respuestaIzq, 'respuestaDerecha', respuestaDer);
    save(archivoDatos, 'ResultadosAudio');
    fprintf('Izquierda: %s\nDerecha: %s\n', respuestaIzq, respuestaDer);
    msgbox('Prueba de audio terminada. El resultado se guardo automaticamente.', ...
        'CajaValentia');
catch ME
    if ~isempty(GS)
        try
            stop(GS);
        catch
        end
    end
    cmc_registra_error_audio(ME);
    rethrow(ME)
end


function cmc_registra_error_audio(ME)
fprintf('ERROR [%s]: %s\n', ME.identifier, ME.message);
for k = 1:length(ME.stack)
    fprintf('  en %s (linea %d)\n', ME.stack(k).name, ME.stack(k).line);
end
