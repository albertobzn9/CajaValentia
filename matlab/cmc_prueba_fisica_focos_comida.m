function cmc_prueba_fisica_focos_comida
%CMC_PRUEBA_FISICA_FOCOS_COMIDA Alterna focos sin otros estimulos.
% Ejecutar con la caja vacia y una persona entrenada presente.

cmc_setup_paths();
cmc_verifica_rutas_prueba_focos;

respuesta = questdlg([ ...
    'Esta prueba encendera los focos de comida y el LED marcador en los pasos ', ...
    'de riesgo. No activara sonido, descarga ni dispensadores. ', ...
    'Confirma que la caja esta vacia.'], ...
    'CajaValentia - prueba de focos', 'Ejecutar', 'Cancelar', 'Cancelar');
if ~strcmp(respuesta,'Ejecutar')
    disp('Prueba cancelada.');
    return
end

archivoLog = fullfile(cmc_results_dir(), 'prueba_fisica_focos_comida.txt');
if exist(archivoLog,'file')
    delete(archivoLog);
end
diary(archivoLog);
limpiaLog = onCleanup(@() diary('off'));

try
    daqreset
    OA = OA_ValentiaInicio;
    limpiaCaja = onCleanup(@() cmc_cierra_prueba_focos(OA));
    cmc_apaga_focos_prueba(OA);

    Lados = {'I','D','I','D'};
    Tipos = [0 0 1 1];
    for Ciclo = 1:5
        for Paso = 1:length(Lados)
            Lado = Lados{Paso};
            TipoEvento = Tipos(Paso);
            fprintf('Ciclo %d: objetivo=%s, tipo=%d.\n',Ciclo,Lado,TipoEvento);
            cmc_activar_foco_objetivo(OA,Lado,TipoEvento,1);
            pause(2);
        end
    end

    cmc_apaga_focos_prueba(OA);
    msgbox(['Prueba terminada. Confirma que nunca se encendieron los dos focos ', ...
        'de comida y que ambos quedaron apagados.'], 'CajaValentia');
catch ME
    fprintf('ERROR [%s]: %s\n',ME.identifier,ME.message);
    rethrow(ME)
end
end


function cmc_verifica_rutas_prueba_focos
Raiz = cmc_root();
Funciones = {'cmc_activar_foco_objetivo','OA_ValentiaEstimuloI', ...
    'OA_ValentiaEstimuloD','escribePto'};
for i = 1:length(Funciones)
    Ruta = which(Funciones{i});
    fprintf('%s: %s\n',Funciones{i},Ruta);
    if isempty(Ruta) || ~strncmpi(Ruta,Raiz,length(Raiz))
        error('CajaValentia:RutasPruebaFocos', ...
            'La funcion %s proviene de otra copia: %s',Funciones{i},Ruta);
    end
end
end


function cmc_apaga_focos_prueba(OA)
if isempty(OA)
    return
end
OA_ValentiaEstimuloI(OA,0,0);
OA_ValentiaEstimuloD(OA,0,0);
end


function cmc_cierra_prueba_focos(OA)
try
    cmc_apaga_focos_prueba(OA);
    daqreset
catch
end
end
