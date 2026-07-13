function cmc_prueba_reloj_habituacion
%CMC_PRUEBA_RELOJ_HABITUACION Verifica el reloj visible sin caja ni tarjeta.

figura = figure('Visible', 'off');
limpieza = onCleanup(@() close(figura)); %#ok<NASGU>
uicontrol('Parent', figura, 'Style', 'text', 'Tag', 'text10');
reloj = uicontrol('Parent', figura, 'Style', 'edit', 'Tag', 'edit9');

cmc_actualizar_reloj_fase(reloj, 'Habituacion inicial (s)', 3.25, 15);
etiqueta = findobj(figura, 'Tag', 'text10');
assert(strcmp(get(etiqueta, 'String'), 'Reloj hab. (s)'));
assert(strcmp(get(reloj, 'String'), '3.2 / 15.0'));

cmc_actualizar_reloj_fase(reloj, 'Reloj de duracion del ensayo (s)', 1.234, []);
assert(strcmp(get(etiqueta, 'String'), 'Reloj ensayo (s)'));
assert(strcmp(get(reloj, 'String'), '1.23'));
disp('OK: reloj compacto para habituacion y ensayo.');
