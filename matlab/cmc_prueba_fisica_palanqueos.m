function cmc_prueba_fisica_palanqueos
%CMC_PRUEBA_FISICA_PALANQUEOS Caracteriza los contadores sin activar la caja.
% No activa luz, sonido, pellet ni descarga. Ejecutar con la caja sin rata.

cmc_setup_paths();
archivoBase = fullfile(cmc_results_dir(), 'prueba_fisica_palanqueos');
archivoLog = [archivoBase '.txt'];
if exist(archivoLog, 'file')
    delete(archivoLog);
end

diary(archivoLog);
limpiaLog = onCleanup(@() diary('off'));
OA = [];
try
    respuesta = questdlg(['Esta prueba solo lee los contadores de palanca. ', ...
        'No habra luz, sonido, pellet ni descarga. Ejecutar con la caja sin rata.'], ...
        'CajaValentia - prueba de palanqueos', 'Iniciar', 'Cancelar', 'Cancelar');
    if ~strcmp(respuesta, 'Iniciar')
        disp('Prueba cancelada.');
        return
    end

    daqreset
    OA = OA_ValentiaInicio;
    cmc_apaga_caja_prueba_palanqueos(OA);
    limpiaCaja = onCleanup(@() cmc_cierra_prueba_palanqueos(OA));

    nombres = {'una_izquierda', 'una_derecha', ...
        'tres_izquierda_rapidas', 'tres_derecha_rapidas'};
    instrucciones = { ...
        'Presiona UNA vez la palanca izquierda durante la ventana de 4 segundos.', ...
        'Presiona UNA vez la palanca derecha durante la ventana de 4 segundos.', ...
        'Presiona TRES veces rapido la palanca izquierda durante la ventana de 4 segundos.', ...
        'Presiona TRES veces rapido la palanca derecha durante la ventana de 4 segundos.'};

    MuestrasPalanqueo = [];
    EventosPalanqueo = struct('tiempo_s', {}, 'fase', {}, 'ensayo', {}, ...
        'tipo_evento', {}, 'lado', {}, 'contador_hardware', {});
    ResumenPasos = struct('nombre', {}, 'delta_izq', {}, 'delta_der', {});
    R0 = tic;

    for paso = 1:numel(nombres)
        respuesta = questdlg(instrucciones{paso}, ...
            'CajaValentia - siguiente paso', 'Abrir ventana', 'Cancelar', 'Abrir ventana');
        if ~strcmp(respuesta, 'Abrir ventana')
            disp('Prueba cancelada por el operador.');
            break
        end

        [muestras, eventos, deltaI, deltaD] = cmc_captura_palanqueos( ...
            OA, R0, paso, nombres{paso});
        MuestrasPalanqueo = [MuestrasPalanqueo; muestras];
        EventosPalanqueo = [EventosPalanqueo eventos];
        ResumenPasos(end + 1) = struct('nombre', nombres{paso}, ...
            'delta_izq', deltaI, 'delta_der', deltaD);
        fprintf('%s: izquierda=%d, derecha=%d\n', nombres{paso}, deltaI, deltaD);
        msgbox(sprintf('%s\nContador izquierdo: %d\nContador derecho: %d', ...
            nombres{paso}, deltaI, deltaD), 'CajaValentia');
    end

    save([archivoBase '.mat'], 'MuestrasPalanqueo', 'EventosPalanqueo', ...
        'ResumenPasos', 'nombres', 'instrucciones');
    cmc_escribir_csv_palanqueos([archivoBase '_eventos.csv'], EventosPalanqueo);
    msgbox(['Prueba terminada. Se guardaron .mat, CSV y log en resultados. ', ...
        'No hubo estimulos ni recompensa.'], 'CajaValentia');
catch ME
    if ~isempty(OA)
        cmc_apaga_caja_prueba_palanqueos(OA);
    end
    fprintf('ERROR [%s]: %s\n', ME.identifier, ME.message);
    rethrow(ME)
end


function [muestras, eventos, deltaI, deltaD] = cmc_captura_palanqueos(OA, R0, paso, nombrePaso)
duracion = 4;
intervalo = .05;
OA_ValentiaResetPalancas(OA);
[DI, DD] = OA_ValentiaRevisaPalanca(OA);
[estado, eventos] = cmc_nuevo_registro_palanqueos;
estado = cmc_reiniciar_referencia_palanqueos(estado, DI, DD);
muestras = [];
deltaI = 0;
deltaD = 0;
R = tic;

while toc(R) < duracion
    [DI, DD] = OA_ValentiaRevisaPalanca(OA);
    tiempo = toc(R0);
    [estado, eventos, nuevaI, nuevaD] = cmc_registrar_palanqueos( ...
        estado, eventos, DI, DD, tiempo, 'prueba_fisica', paso, nombrePaso);
    deltaI = deltaI + nuevaI;
    deltaD = deltaD + nuevaD;
    muestras = [muestras; paso tiempo DI DD nuevaI nuevaD];
    pause(intervalo);
end


function cmc_apaga_caja_prueba_palanqueos(OA)
OA_ValentiaElectrico(OA, 0);
OA_ValentiaEstimuloI(OA, 0, 0);
OA_ValentiaEstimuloD(OA, 0, 0);


function cmc_cierra_prueba_palanqueos(OA)
try
    cmc_apaga_caja_prueba_palanqueos(OA);
    daqreset
catch
end
