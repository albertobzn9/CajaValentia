function cmc_prueba_contador_habituacion
%CMC_PRUEBA_CONTADOR_HABITUACION Verifica el contador dedicado sin caja.

figura = figure('Visible', 'off');
limpieza = onCleanup(@() close(figura)); %#ok<NASGU>
contador = uicontrol('Parent', figura, 'Style', 'text');

cmc_actualizar_contador_habituacion(contador, 'inicial', 18.8, 30);
assert(strcmp(get(contador, 'String'), 'Hab. inicial: 00:18 / 00:30'));

cmc_actualizar_contador_habituacion(contador, 'final', 301, 300);
assert(strcmp(get(contador, 'String'), 'Hab. final: 05:00 / 05:00'));

cmc_actualizar_contador_habituacion(contador, 'ninguna', 0, []);
assert(strcmp(get(contador, 'String'), 'Hab.: --'));
disp('OK: contador dedicado de habituacion validado sin hardware.');
