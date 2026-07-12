function cmc_escribir_csv_palanqueos(rutaArchivo, eventos)
%CMC_ESCRIBIR_CSV_PALANQUEOS Guarda eventos en un CSV legible fuera de MATLAB.

fid = fopen(rutaArchivo, 'wt');
if fid == -1
    error('CajaValentia:CSV', 'No se pudo abrir el archivo: %s', rutaArchivo);
end

limpieza = onCleanup(@() fclose(fid));
fprintf(fid, 'tiempo_s,fase,ensayo,tipo_evento,lado,contador_hardware\n');
for i = 1:numel(eventos)
    e = eventos(i);
    fprintf(fid, '%.3f,%s,%d,%s,%s,%d\n', e.tiempo_s, e.fase, ...
        e.ensayo, e.tipo_evento, e.lado, e.contador_hardware);
end
