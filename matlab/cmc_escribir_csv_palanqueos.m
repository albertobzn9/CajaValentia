function cmc_escribir_csv_palanqueos(rutaArchivo, eventos)
%CMC_ESCRIBIR_CSV_PALANQUEOS Guarda eventos en un CSV legible fuera de MATLAB.

fid = fopen(rutaArchivo, 'wt');
if fid == -1
    error('CajaValentia:CSV', 'No se pudo abrir el archivo: %s', rutaArchivo);
end

limpieza = onCleanup(@() fclose(fid));
fprintf(fid, ['evento_sesion,tiempo_s,fase,ensayo,tipo_evento,lado,' ...
    'contador_lado_sesion,contador_hardware\n']);
for i = 1:numel(eventos)
    e = eventos(i);
    if isnan(e.ensayo)
        ensayoTexto = 'NA';
    else
        ensayoTexto = num2str(e.ensayo);
    end
    fprintf(fid, '%d,%.3f,%s,%s,%s,%s,%d,%d\n', ...
        e.evento_sesion, e.tiempo_s, e.fase, ensayoTexto, ...
        e.tipo_evento, e.lado, e.contador_lado_sesion, ...
        e.contador_hardware);
end
