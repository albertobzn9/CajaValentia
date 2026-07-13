function cmc_prueba_resumen_sesion
%CMC_PRUEBA_RESUMEN_SESION Verifica el resumen automatico sin caja.

carpeta = tempname;
mkdir(carpeta);
limpieza = onCleanup(@() rmdir(carpeta, 's')); %#ok<NASGU>
rutaCsv = fullfile(carpeta, 'prueba.csv');

Resultados = [ ...
    1 1 0 1.0 1.0 0 0 1.0 0 1; ...
    2 0 1 2.0 3.0 0 0 2.0 1 0; ...
    3 1 1 180.0 183.0 0 0 1.0 2 -1];
EventosPalanqueo = [ ...
    cmc_evento_palanqueo(1, 1, 'habituacion_inicial', NaN, 'ninguno', 'I', 1, 1), ...
    cmc_evento_palanqueo(2, 2, 'ensayo', 1, 'seguro', 'D', 1, 2), ...
    cmc_evento_palanqueo(3, 4, 'habituacion_final', NaN, 'ninguno', 'I', 2, 3)];

[rutaResumen, rutaReferencia] = cmc_escribir_resumen_sesion( ...
    rutaCsv, Resultados, EventosPalanqueo, false);
assert(exist(rutaResumen, 'file') == 2);
assert(isempty(rutaReferencia));
texto = fileread(rutaResumen);
assert(~isempty(strfind(texto, 'Eventos terminados: 3')));
assert(~isempty(strfind(texto, 'Solo sonido (tipo 2): 1')));
assert(~isempty(strfind(texto, 'Palanqueos habituacion_final: 1')));
disp('OK: resumen automatico de sesion validado sin hardware.');
