function cmc_prueba_cierre_sin_hardware
%CMC_PRUEBA_CIERRE_SIN_HARDWARE Verifica limpieza del aviso LED sin caja.

assert(cmc_led_aviso_activo(0));
assert(cmc_led_aviso_activo(0.099));
assert(~cmc_led_aviso_activo(0.1));
assert(~cmc_led_aviso_activo(1.999));
assert(cmc_led_aviso_activo(2));
assert(isempty(cmc_iniciar_aviso_led_final([])));

aviso = timer('ExecutionMode', 'singleShot', 'StartDelay', 5, ...
    'Tag', 'CajaValentiaAvisoLedFinal', 'TimerFcn', '');
start(aviso);
cmc_detener_aviso_led_final(aviso, []);
assert(isempty(timerfindall('Tag', 'CajaValentiaAvisoLedFinal')), ...
    'El cierre debe eliminar timers LED pendientes.');

disp('OK: cierre de aviso LED validado sin hardware.');
