function guardado = cmc_solicitar_guardado_final(Resultados, EventosPalanqueo)
%CMC_SOLICITAR_GUARDADO_FINAL Pide ruta al terminar y guarda MAT mas CSV.
% En Windows inicia en Documents del usuario. Cancelar o presionar Esc no
% escribe ningun archivo nuevo.

carpetaInicial = fullfile(getenv('USERPROFILE'), 'Documents');
if ~exist(carpetaInicial, 'dir')
    carpetaInicial = pwd;
end

[nombre, carpeta] = uiputfile(fullfile(carpetaInicial, 'resultados.mat'), ...
    'Guardar resultados de la sesion');
if isequal(nombre,0) || isequal(carpeta,0)
    guardado = false;
    return
end

cmc_guardar_resultados_sesion(fullfile(carpeta,nombre),Resultados,EventosPalanqueo);
guardado = true;
