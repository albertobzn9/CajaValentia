function rutaCsv = cmc_escribir_csv_resultados(rutaCsv, resultados)
%CMC_ESCRIBIR_CSV_RESULTADOS Exporta las diez columnas de Resultados a CSV.
% La fila conserva el orden del array MATLAB; los encabezados dan significado
% explicito a cada columna para Python, Excel u otro analisis posterior.

[carpeta, nombre, extension] = fileparts(rutaCsv);
if ~strcmpi(extension, '.csv')
    rutaCsv = fullfile(carpeta, [nombre '.csv']);
end

fid = fopen(rutaCsv, 'wt');
if fid == -1
    error('CajaValentia:CSV', 'No se pudo abrir el archivo: %s', rutaCsv);
end
limpieza = onCleanup(@() fclose(fid));

fprintf(fid, ['ensayo,lado,estimulo,latencia_s,tiempo_absoluto_s,' ...
    'palancas_izq,palancas_der,desplazamiento_s,tipo_evento,ensayo_cruce\n']);
for i = 1:size(resultados, 1)
    fila = resultados(i,:);
    if size(resultados,2) < 10
        % Compatibilidad de lectura para matrices historicas de nueve columnas.
        ensayoCruce = 'NA';
    elseif fila(10) < 0
        ensayoCruce = 'NA';
    else
        ensayoCruce = sprintf('%d', round(fila(10)));
    end
    fprintf(fid, '%d,%d,%d,%.6f,%.6f,%d,%d,%.6f,%d,%s\n', ...
        fila(1), fila(2), fila(3), fila(4), fila(5), fila(6), ...
        fila(7), fila(8), fila(9), ensayoCruce);
end
