function cmc_configurar_tabla_resultados(tabla)
%CMC_CONFIGURAR_TABLA_RESULTADOS Configura el formato comun de Resultados.
% Compatible con GUIDE/R2011a. La columna 9 siempre identifica el evento.

nombres = {'Ens.','Lado','Est.','Lat.','T. abs.','Pal. I', ...
    'Pal. D','Despl.','Tipo'};
anchos = {59, 53, 67, 73, 86, 67, 67, 86, 69};
set(tabla, 'ColumnName', nombres, 'ColumnWidth', anchos);

% Ajusta el contenedor al ancho real de las nueve columnas, mas bordes y
% encabezado de filas. Evita el espacio vacio que dejaba GUIDE a la derecha.
unidadesOriginales = get(tabla, 'Units');
set(tabla, 'Units', 'pixels');
posPixeles = get(tabla, 'Position');
posPixeles(3) = sum([anchos{:}]) + 24;
set(tabla, 'Position', posPixeles);
set(tabla, 'Units', unidadesOriginales);

% Conserva el borde superior y crea abajo el mismo margen que Sin luz.
posTabla = get(tabla, 'Position');
campoSinLuz = findobj(get(tabla, 'Parent'), 'Tag', 'edit23');
if ~isempty(campoSinLuz)
    posSinLuz = get(campoSinLuz(1), 'Position');
    margen = posSinLuz(2) - (posTabla(2) + posTabla(4));
    if margen > 0
        bordeSuperior = posTabla(2) + posTabla(4);
        posTabla(2) = margen;
        posTabla(4) = bordeSuperior - margen;
        set(tabla, 'Position', posTabla);
    end
end
