function rutaCsv = cmc_guardar_resultados_sesion(rutaCsv, Resultados, EventosPalanqueo)
%CMC_GUARDAR_RESULTADOS_SESION Exporta resultados y palanqueos como dos CSV.
% Los MAT de estado siguen siendo internos y no son el formato de entrega.

rutaCsv = cmc_escribir_csv_resultados(rutaCsv, Resultados);
[carpeta, nombre] = fileparts(rutaCsv);
cmc_escribir_csv_palanqueos(fullfile(carpeta, [nombre '_palanqueos.csv']), ...
    EventosPalanqueo);

try
    cmc_escribir_resumen_sesion(rutaCsv, Resultados, EventosPalanqueo);
catch ME
    % El CSV es el resultado principal: un resumen fallido no debe impedirlo.
    warning('CajaValentia:ResumenSesion', ...
        'No se pudo escribir el resumen de sesion: %s', ME.message);
end
