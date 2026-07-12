function cmc_mostrar_tabla_resultados(tabla, resultados)
%CMC_MOSTRAR_TABLA_RESULTADOS Muestra una vista compacta sin alterar resultados.

vista = cell(size(resultados));
for fila = 1:size(resultados, 1)
    for columna = 1:size(resultados, 2)
        if columna == 10 && resultados(fila, columna) < 0
            vista{fila, columna} = 'NA';
        elseif any(columna == [4 5 8])
            vista{fila, columna} = sprintf('%.2f', resultados(fila, columna));
        else
            vista{fila, columna} = sprintf('%d', round(resultados(fila, columna)));
        end
    end
end

set(tabla, 'Data', vista);
