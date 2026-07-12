function cmc_prueba_resultados_diez_columnas
%CMC_PRUEBA_RESULTADOS_DIEZ_COLUMNAS Verifica tabla y CSV sin hardware.

raiz = cmc_setup_paths();
cmc_verifica_tabla_guide(fullfile(raiz,'OA_ValentiaCuatroE.fig'));
cmc_verifica_tabla_guide(fullfile(raiz,'OA_ValentiaCuatroE2.fig'));

Resultados = [ ...
    1 1 0 10 10 0 0 8 0 1; ...
    2 0 1 12 22 1 0 9 1 0; ...
    3 1 1 180 202 1 1 25 2 -1]; %#ok<NASGU>
assert(size(Resultados,2) == 10, 'Cada resultado debe tener diez columnas.');
assert(isequal(Resultados(:,9)',[0 1 2]), ...
    'La columna 9 debe conservar los tipos 0, 1 y 2.');
assert(isequal(Resultados(:,10)',[1 0 -1]), ...
    'La columna 10 debe registrar el estado del cruce.');

archivo = [tempname '.csv'];
limpiaArchivo = onCleanup(@() cmc_borra_archivo_prueba(archivo)); %#ok<NASGU>
[~, eventos] = cmc_nuevo_registro_palanqueos;
cmc_guardar_resultados_sesion(archivo,Resultados,eventos);
fid = fopen(archivo,'rt');
cabecera = fgetl(fid);
primeraFila = fgetl(fid);
fgetl(fid);
filaSonido = fgetl(fid);
fclose(fid);
assert(strcmp(cabecera, ['ensayo,lado,estimulo,latencia_s,tiempo_absoluto_s,' ...
    'palancas_izq,palancas_der,desplazamiento_s,tipo_evento,ensayo_cruce']));
assert(strcmp(primeraFila,'1,1,0,10.000000,10.000000,0,0,8.000000,0,1'));
assert(strcmp(filaSonido,'3,1,1,180.000000,202.000000,1,1,25.000000,2,NA'));
assert(exist([archivo(1:end-4) '_palanqueos.csv'],'file') == 2);

disp('OK: tabla y CSV conservan diez columnas, tipos y ensayo de cruce.');
end


function cmc_verifica_tabla_guide(rutaFigura)
figura = hgload(rutaFigura);
limpiaFigura = onCleanup(@() delete(figura)); %#ok<NASGU>
tabla = findobj(figura,'Tag','uitable1');
cmc_configurar_tabla_resultados(tabla);

nombres = get(tabla,'ColumnName');
assert(length(nombres) == 10, 'La tabla debe mostrar diez columnas.');
assert(strcmp(nombres{9},'Tipo'), 'La columna 9 debe llamarse Tipo.');
assert(strcmp(nombres{10},'E. cruce'), 'La columna 10 debe llamarse E. cruce.');
end


function cmc_borra_archivo_prueba(archivo)
if exist(archivo,'file')
    delete(archivo);
end
archivoPalanqueos = [archivo(1:end-4) '_palanqueos.csv'];
if exist(archivoPalanqueos,'file')
    delete(archivoPalanqueos);
end
end
