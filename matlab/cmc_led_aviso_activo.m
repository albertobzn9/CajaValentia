function activo = cmc_led_aviso_activo(tiempo_s)
%CMC_LED_AVISO_ACTIVO Verdadero durante 100 ms al inicio de cada segundo.

activo = mod(max(0, tiempo_s), 1) < 0.1;
