function cmc_prueba_aviso_led_final
%CMC_PRUEBA_AVISO_LED_FINAL Verifica el calendario y layout sin hardware.

assert(cmc_led_aviso_activo(0));
assert(cmc_led_aviso_activo(0.099));
assert(~cmc_led_aviso_activo(0.1));
assert(~cmc_led_aviso_activo(1.999));
assert(cmc_led_aviso_activo(2));
assert(isempty(cmc_iniciar_aviso_led_final([])));

posiciones = cmc_posiciones_gui_experimental;
assert(~cmc_se_traslapan(posiciones.sonidoSolo, posiciones.avisoLedFinal));
editEnsayos = [139.8 53.4615 13.4 2.23077];
assert(~cmc_se_traslapan(posiciones.avisoLedFinal, editEnsayos));
disp('OK: aviso LED final y posiciones de controles validados sin hardware.');

function seTraslapan = cmc_se_traslapan(a, b)
seTraslapan = a(1) < b(1) + b(3) && b(1) < a(1) + a(3) && ...
    a(2) < b(2) + b(4) && b(2) < a(2) + a(4);
