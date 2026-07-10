function cmc_configurar_tabla_resultados(tabla)
%CMC_CONFIGURAR_TABLA_RESULTADOS Configura el formato comun de Resultados.
% Compatible con GUIDE/R2011a. La columna 9 siempre identifica el evento.

nombres = {'Ensayo','Lado','Estim. electrico','Latencia', ...
    'Tiempo absoluto','Palancas izq.','Palancas der.', ...
    'Desplazamiento','Tipo evento'};
set(tabla, 'ColumnName', nombres);
