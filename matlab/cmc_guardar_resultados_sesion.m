function cmc_guardar_resultados_sesion(rutaMat, Resultados, EventosPalanqueo)
%CMC_GUARDAR_RESULTADOS_SESION Guarda resultados MATLAB y CSV de palanqueos.

save(rutaMat, 'Resultados', 'EventosPalanqueo');
[carpeta, nombre] = fileparts(rutaMat);
cmc_escribir_csv_palanqueos(fullfile(carpeta, [nombre '_palanqueos.csv']), ...
    EventosPalanqueo);
