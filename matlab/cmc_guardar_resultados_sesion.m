function cmc_guardar_resultados_sesion(rutaCsv, Resultados, EventosPalanqueo)
%CMC_GUARDAR_RESULTADOS_SESION Guarda CSV principal y CSV de palanqueos.

rutaCsv = cmc_escribir_csv_resultados(rutaCsv, Resultados);
[carpeta, nombre] = fileparts(rutaCsv);
cmc_escribir_csv_palanqueos(fullfile(carpeta, [nombre '_palanqueos.csv']), ...
    EventosPalanqueo);
