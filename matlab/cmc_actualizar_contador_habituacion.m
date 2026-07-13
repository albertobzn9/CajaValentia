function cmc_actualizar_contador_habituacion(control, fase, transcurrido, total)
%CMC_ACTUALIZAR_CONTADOR_HABITUACION Muestra el progreso de cada habituacion.

if isempty(control) || ~ishandle(control)
    return
end

if nargin < 4 || isempty(total)
    set(control, 'String', 'Hab.: --');
    return
end

transcurrido = max(0, min(total, transcurrido));
if strcmpi(fase, 'inicial')
    nombre = 'Hab. inicial';
elseif strcmpi(fase, 'final')
    nombre = 'Hab. final';
else
    nombre = 'Hab.';
end

set(control, 'String', sprintf('%s: %s / %s', nombre, ...
    cmc_formato_habituacion(transcurrido), cmc_formato_habituacion(total)));
drawnow;


function texto = cmc_formato_habituacion(segundos)
segundos = floor(max(0, segundos));
texto = sprintf('%02d:%02d', floor(segundos / 60), mod(segundos, 60));
