function cmc_prueba_layout_detener_cp
%CMC_PRUEBA_LAYOUT_DETENER_CP Asegura que el boton nuevo no se sobrepone.

rutaFigura = fullfile(cmc_root, 'OA_ValentiaCuatroE2.fig');
figura = openfig(rutaFigura, 'invisible');
limpieza = onCleanup(@() cmc_cerrar_figura_prueba(figura));

detener = findobj(figura, 'Tag', 'Terminarn2');
inicio = findobj(figura, 'Tag', 'Inicio');
guardar = findobj(figura, 'Tag', 'pushbutton3');
posDetener = get(detener, 'Position');
posInicio = get(inicio, 'Position');
posGuardar = get(guardar, 'Position');
posicionNueva = cmc_posicion_detener_tras_ensayo(posDetener);

assert(posicionNueva(2) >= posDetener(2) + posDetener(4));
assert(posicionNueva(2) + posicionNueva(4) <= posInicio(2));
assert(posicionNueva(2) >= posGuardar(2) + posGuardar(4));
fprintf('OK: boton CP Detener tras ensayo no se sobrepone.\n');

function cmc_cerrar_figura_prueba(figura)
if ishandle(figura)
    set(figura, 'CloseRequestFcn', '');
    delete(figura);
end
