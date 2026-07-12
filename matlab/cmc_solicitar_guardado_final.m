function guardado = cmc_solicitar_guardado_final(Resultados, EventosPalanqueo, OA, ActivarAvisoLed)
%CMC_SOLICITAR_GUARDADO_FINAL Pide ruta al terminar y exporta dos CSV.
% En Windows inicia en Documents del usuario. Cancelar o presionar Esc no
% escribe ningun archivo nuevo.

if nargin < 3
    OA = [];
end
if nargin < 4
    ActivarAvisoLed = false;
end

aviso = [];
if ActivarAvisoLed
    aviso = cmc_iniciar_aviso_led_final(OA);
    limpiezaAviso = onCleanup(@() cmc_detener_aviso_led_final(aviso, OA));
end

carpetaInicial = fullfile(getenv('USERPROFILE'), 'Documents');
if ~exist(carpetaInicial, 'dir')
    carpetaInicial = pwd;
end

filtroCsv = {'*.csv', 'CSV (*.csv)'; '*.*', 'Todos los archivos'};
[nombre, carpeta] = uiputfile(filtroCsv, 'Guardar resultados de la sesion', ...
    fullfile(carpetaInicial, 'resultados.csv'));
if isequal(nombre,0) || isequal(carpeta,0)
    guardado = false;
    return
end

cmc_guardar_resultados_sesion(fullfile(carpeta,nombre),Resultados,EventosPalanqueo);
guardado = true;
