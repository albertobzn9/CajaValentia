function cmc_configurar_tabla_resultados(tabla)
%CMC_CONFIGURAR_TABLA_RESULTADOS Configura el formato comun de Resultados.
% Compatible con GUIDE/R2011a. La columna 9 siempre identifica el evento.

nombres = {'Ens.','Lado','Est.','Lat.','T. abs.','Pal. I', ...
    'Pal. D','Despl.','Tipo'};
anchos = {86, 78, 98, 108, 127, 98, 98, 127, 102};
set(tabla, 'ColumnName', nombres, 'ColumnWidth', anchos);

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
