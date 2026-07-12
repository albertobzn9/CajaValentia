function guardado = cmc_solicitar_guardado_final(Resultados, EventosPalanqueo)
%CMC_SOLICITAR_GUARDADO_FINAL Pide ruta al terminar y guarda MAT mas CSV.
% En Windows inicia en C: para que el usuario pueda elegir la USB desde
% Este equipo. Cancelar o presionar Esc no escribe ningun archivo nuevo.

unidadSistema = getenv('SystemDrive');
if isempty(unidadSistema)
    unidadSistema = 'C:';
end
rutaInicial = [unidadSistema '\resultados.mat'];

[nombre, carpeta] = uiputfile(rutaInicial, ...
    'Guardar resultados de la sesion - elegir USB en Este equipo');
if isequal(nombre,0) || isequal(carpeta,0)
    guardado = false;
    return
end

cmc_guardar_resultados_sesion(fullfile(carpeta,nombre),Resultados,EventosPalanqueo);
guardado = true;
