function cmc_configurar_tabla_resultados(tabla)
%CMC_CONFIGURAR_TABLA_RESULTADOS Configura el formato comun de Resultados.
% Compatible con GUIDE/R2011a. La columna 9 siempre identifica el evento.

nombres = {'Ens.','Lado','Est.','Lat.','T. abs.','Pal. I', ...
    'Pal. D','Despl.','Tipo'};
anchos = {46, 42, 52, 58, 68, 52, 52, 68, 54};
set(tabla, 'ColumnName', nombres, 'ColumnWidth', anchos);
