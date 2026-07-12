function cmc_prueba_fisica_posicion
%CMC_PRUEBA_FISICA_POSICION Mapea los sensores de posicion sin estimulos.
% No activa luz, sonido, pellet ni descarga. Ejecutar con la caja sin rata.

cmc_setup_paths();
archivoBase = fullfile(cmc_results_dir(), 'prueba_fisica_posicion');
archivoLog = [archivoBase '.txt'];
if exist(archivoLog, 'file')
    delete(archivoLog);
end

diary(archivoLog);
limpiaLog = onCleanup(@() diary('off'));
OA = [];
try
    respuesta = questdlg(['Esta prueba solo lee los laseres de posicion. ', ...
        'No habra luz, sonido, pellet ni descarga.'], ...
        'CajaValentia - prueba de posicion', 'Iniciar', 'Cancelar', 'Cancelar');
    if ~strcmp(respuesta, 'Iniciar')
        disp('Prueba cancelada.');
        return
    end

    daqreset
    OA = OA_ValentiaInicio;
    cmc_apaga_caja_prueba_posicion(OA);
    limpiaCaja = onCleanup(@() cmc_cierra_prueba_posicion(OA));

    nombres = {'izquierda', 'centro', 'derecha'};
    instrucciones = { ...
        'Coloca la mano extendida en la zona izquierda y mantenla ahi.', ...
        'Coloca la mano extendida en el centro de la caja y mantenla ahi.', ...
        'Coloca la mano extendida en la zona derecha y mantenla ahi.'};

    PatronesPosicion = [];
    ResumenPosicion = struct('zona', {}, 'lado_estimado', {}, ...
        'promedio_sensor', {}, 'muestras_activas', {});

    for paso = 1:numel(nombres)
        respuesta = questdlg(instrucciones{paso}, ...
            'CajaValentia - siguiente zona', 'Capturar 2 segundos', 'Cancelar', ...
            'Capturar 2 segundos');
        if ~strcmp(respuesta, 'Capturar 2 segundos')
            disp('Prueba cancelada por el operador.');
            break
        end

        [patrones, lado, promedio] = cmc_captura_posicion(OA, paso);
        PatronesPosicion = [PatronesPosicion; patrones];
        activas = sum(sum(patrones(:, 3:end)));
        ResumenPosicion(end + 1) = struct('zona', nombres{paso}, ...
            'lado_estimado', lado, 'promedio_sensor', promedio, ...
            'muestras_activas', activas);
        fprintf('%s: lado=%s, promedio sensor=%.2f, activas=%d\n', ...
            nombres{paso}, lado, promedio, activas);
    end

    save([archivoBase '.mat'], 'PatronesPosicion', 'ResumenPosicion', ...
        'nombres', 'instrucciones');
    cmc_escribir_csv_posicion([archivoBase '.csv'], PatronesPosicion);
    msgbox(['Prueba terminada. Se guardaron .mat, CSV y log en resultados. ', ...
        'No hubo estimulos ni recompensa.'], 'CajaValentia');
catch ME
    if ~isempty(OA)
        cmc_apaga_caja_prueba_posicion(OA);
    end
    fprintf('ERROR [%s]: %s\n', ME.identifier, ME.message);
    rethrow(ME)
end


function [patrones, lado, promedio] = cmc_captura_posicion(OA, paso)
duracion = 2;
intervalo = .1;
patrones = [];
R = tic;
while toc(R) < duracion
    lugar = cmc_lee_posicion_cruda(OA);
    donde = find(lugar == 1);
    if isempty(donde)
        promedio = NaN;
        lado = 'ninguno';
    else
        promedio = mean(donde);
        if sum(donde < 9) >= sum(donde >= 9)
            lado = 'I';
        else
            lado = 'D';
        end
    end
    patrones = [patrones; paso toc(R) lugar];
    pause(intervalo);
end


function lugar = cmc_lee_posicion_cruda(OA)
selectores = [0 0 0 0; 1 0 0 0; 0 1 0 0];
datos = [];
for i = 1:3
    escribePto(OA, 9:16, [selectores(i,:) 0 0 0 0]);
    pause(.01);
    datos = [datos getvalue(OA.Line(1:8))];
end
lugar = not(datos(2:19));
lugar = fliplr(lugar);


function cmc_escribir_csv_posicion(rutaArchivo, patrones)
fid = fopen(rutaArchivo, 'wt');
if fid == -1
    error('CajaValentia:CSV', 'No se pudo abrir el archivo: %s', rutaArchivo);
end
limpieza = onCleanup(@() fclose(fid));
fprintf(fid, 'paso,tiempo_s');
for i = 1:18
    fprintf(fid, ',sensor_%02d', i);
end
fprintf(fid, '\n');
for i = 1:size(patrones, 1)
    fprintf(fid, '%d,%.3f', patrones(i,1), patrones(i,2));
    fprintf(fid, ',%d', patrones(i,3:end));
    fprintf(fid, '\n');
end


function cmc_apaga_caja_prueba_posicion(OA)
OA_ValentiaElectrico(OA, 0);
OA_ValentiaEstimuloI(OA, 0, 0);
OA_ValentiaEstimuloD(OA, 0, 0);


function cmc_cierra_prueba_posicion(OA)
try
    cmc_apaga_caja_prueba_posicion(OA);
    daqreset
catch
end
