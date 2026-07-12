function cmc_prueba_registro_palanqueos
%CMC_PRUEBA_REGISTRO_PALANQUEOS Prueba sin caja el registro de contadores.

[estado, eventos] = cmc_nuevo_registro_palanqueos;
[estado, eventos, izq, der] = cmc_registrar_palanqueos( ...
    estado, eventos, 0, 0, 0, 'habituacion_inicial', 0, 'ninguno');
assert(izq == 0 && der == 0 && isempty(eventos));

[estado, eventos, izq, der] = cmc_registrar_palanqueos( ...
    estado, eventos, 1, 0, 1.0, 'habituacion_inicial', 0, 'ninguno');
assert(izq == 1 && der == 0 && numel(eventos) == 1);

[estado, eventos, izq, der] = cmc_registrar_palanqueos( ...
    estado, eventos, 3, 2, 2.0, 'ensayo', 4, 'riesgo');
assert(izq == 2 && der == 2 && numel(eventos) == 5);
assert(strcmp(eventos(2).fase, 'ensayo'));
assert(eventos(5).ensayo == 4 && strcmp(eventos(5).lado, 'D'));

estado.izq = 15;
[estado, eventos, izq, der] = cmc_registrar_palanqueos( ...
    estado, eventos, 0, 2, 3.0, 'habituacion_final', 0, 'ninguno');
assert(izq == 1 && der == 0 && numel(eventos) == 6);

ruta = [tempname '.csv'];
cmc_escribir_csv_palanqueos(ruta, eventos);
fid = fopen(ruta, 'rt');
cabecera = fgetl(fid);
fclose(fid);
delete(ruta);
assert(strcmp(cabecera, 'tiempo_s,fase,ensayo,tipo_evento,lado,contador_hardware'));

rutaMat = [tempname '.mat'];
Resultados = [1 0 0 1.23 5.67 0 0 2.34 0];
cmc_guardar_resultados_sesion(rutaMat, Resultados, eventos);
datos = load(rutaMat);
assert(isfield(datos, 'Resultados') && isfield(datos, 'EventosPalanqueo'));
[carpeta, nombre] = fileparts(rutaMat);
assert(exist(fullfile(carpeta, [nombre '_palanqueos.csv']), 'file') == 2);
delete(rutaMat);
delete(fullfile(carpeta, [nombre '_palanqueos.csv']));

disp('REGISTRO_PALANQUEOS_TEST_OK');
