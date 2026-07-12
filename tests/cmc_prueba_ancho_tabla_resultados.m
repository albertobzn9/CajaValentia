function cmc_prueba_ancho_tabla_resultados
%CMC_PRUEBA_ANCHO_TABLA_RESULTADOS Verifica que no quede ancho sobrante.

f = figure('Visible', 'off');
limpia = onCleanup(@() close(f));
tabla = uitable('Parent', f, 'Tag', 'uitable1', 'Units', 'pixels', ...
    'Position', [20 20 900 200]);
cmc_configurar_tabla_resultados(tabla);
pos = get(tabla, 'Position');
assert(pos(3) == 649);
disp('OK: ancho de tabla ajustado a diez columnas.');
