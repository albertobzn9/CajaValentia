function [rutaResumen, rutaReferencia] = cmc_escribir_resumen_sesion( ...
    rutaCsv, Resultados, EventosPalanqueo, registrarUltima)
%CMC_ESCRIBIR_RESUMEN_SESION Deja un resumen legible y localizable por SSH.

if nargin < 4
    registrarUltima = true;
end

[carpeta, nombre] = fileparts(rutaCsv);
rutaResumen = fullfile(carpeta, [nombre '_resumen.txt']);
rutaReferencia = '';

fid = fopen(rutaResumen, 'wt');
if fid == -1
    error('CajaValentia:ResumenSesion', ...
        'No se pudo abrir el resumen: %s', rutaResumen);
end
limpieza = onCleanup(@() fclose(fid));

fprintf(fid, 'CajaValentia - resumen de sesion\n');
fprintf(fid, 'Generado: %s\n', datestr(now, 'yyyy-mm-dd HH:MM:SS'));
fprintf(fid, 'CSV principal: %s\n', rutaCsv);
fprintf(fid, 'Eventos terminados: %d\n', size(Resultados, 1));

if size(Resultados, 2) >= 9
    fprintf(fid, 'Seguros (tipo 0): %d\n', sum(Resultados(:,9) == 0));
    fprintf(fid, 'Riesgo (tipo 1): %d\n', sum(Resultados(:,9) == 1));
    fprintf(fid, 'Solo sonido (tipo 2): %d\n', sum(Resultados(:,9) == 2));
end

if size(Resultados, 2) >= 10
    fprintf(fid, 'Ensayos de cruce: %d\n', sum(Resultados(:,10) == 1));
    fprintf(fid, 'Eventos que no cuentan como cruce: %d\n', ...
        sum(Resultados(:,10) == 0));
end

fprintf(fid, 'Palanqueos registrados: %d\n', numel(EventosPalanqueo));
fases = {'habituacion_inicial', 'sin_luz', 'ensayo', 'sonido_solo', ...
    'habituacion_final'};
for i = 1:numel(fases)
    fprintf(fid, 'Palanqueos %s: %d\n', fases{i}, ...
        cmc_contar_fase(EventosPalanqueo, fases{i}));
end

if registrarUltima
    rutaReferencia = fullfile(cmc_results_dir(), 'ultima_sesion_guardada.txt');
    fidReferencia = fopen(rutaReferencia, 'wt');
    if fidReferencia ~= -1
        fprintf(fidReferencia, 'Generado: %s\n', ...
            datestr(now, 'yyyy-mm-dd HH:MM:SS'));
        fprintf(fidReferencia, 'CSV principal: %s\n', rutaCsv);
        fprintf(fidReferencia, 'Resumen: %s\n', rutaResumen);
        fclose(fidReferencia);
    end
end


function total = cmc_contar_fase(eventos, fase)
total = 0;
for i = 1:numel(eventos)
    if strcmp(eventos(i).fase, fase)
        total = total + 1;
    end
end
