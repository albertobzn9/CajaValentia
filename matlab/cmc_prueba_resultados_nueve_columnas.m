function cmc_prueba_resultados_nueve_columnas
%CMC_PRUEBA_RESULTADOS_NUEVE_COLUMNAS Verifica tabla y archivo sin hardware.

raiz = cmc_setup_paths();
cmc_verifica_tabla_guide(fullfile(raiz,'OA_ValentiaCuatroE.fig'));
cmc_verifica_tabla_guide(fullfile(raiz,'OA_ValentiaCuatroE2.fig'));

Resultados = [ ...
    1 1 0 10 10 0 0 8 0; ...
    2 0 1 12 22 1 0 9 1; ...
    3 1 1 180 202 1 1 25 2]; %#ok<NASGU>
assert(size(Resultados,2) == 9, 'Cada resultado debe tener nueve columnas.');
assert(isequal(Resultados(:,9)',[0 1 2]), ...
    'La columna 9 debe conservar los tipos 0, 1 y 2.');

archivo = [tempname '.mat'];
limpiaArchivo = onCleanup(@() cmc_borra_archivo_prueba(archivo)); %#ok<NASGU>
save(archivo,'Resultados');
cargado = load(archivo,'Resultados');
assert(isequal(cargado.Resultados,Resultados), ...
    'Guardar y cargar debe conservar las nueve columnas.');

disp('OK: tabla y archivo conservan las nueve columnas y los tipos 0, 1 y 2.');


function cmc_verifica_tabla_guide(rutaFigura)
figura = hgload(rutaFigura);
limpiaFigura = onCleanup(@() delete(figura)); %#ok<NASGU>
tabla = findobj(figura,'Tag','uitable1');
cmc_configurar_tabla_resultados(tabla);

nombres = get(tabla,'ColumnName');
assert(length(nombres) == 9, 'La tabla debe mostrar nueve columnas.');
assert(strcmp(nombres{9},'Tipo evento'), ...
    'La columna 9 debe llamarse Tipo evento.');


function cmc_borra_archivo_prueba(archivo)
if exist(archivo,'file')
    delete(archivo);
end
