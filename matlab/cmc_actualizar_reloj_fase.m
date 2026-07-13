function cmc_actualizar_reloj_fase(reloj, etiqueta, transcurrido, total)
%CMC_ACTUALIZAR_RELOJ_FASE Muestra el reloj comun durante cada fase.
% TOTAL vacio significa que el reloj pertenece a un ensayo, no a habituacion.

if isempty(reloj) || ~ishandle(reloj)
    return
end

etiquetaControl = findobj(get(reloj, 'Parent'), 'Tag', 'text10');
if ~isempty(etiquetaControl)
    set(etiquetaControl(1), 'String', cmc_etiqueta_reloj_compacta(etiqueta));
end

if nargin < 4 || isempty(total)
    set(reloj, 'String', sprintf('%.2f', max(0, transcurrido)));
else
    total = max(0, total);
    transcurrido = min(total, max(0, transcurrido));
    set(reloj, 'String', sprintf('%.1f / %.1f', transcurrido, total));
end
drawnow;


function texto = cmc_etiqueta_reloj_compacta(etiqueta)
% La etiqueta larga de GUIDE ocupaba el espacio del contador de habituacion.
if ~isempty(strfind(lower(etiqueta), 'habituacion'))
    texto = 'Reloj hab. (s)';
else
    texto = 'Reloj ensayo (s)';
end
