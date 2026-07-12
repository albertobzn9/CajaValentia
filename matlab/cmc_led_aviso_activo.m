function activo = cmc_led_aviso_activo(tiempo_s)
%CMC_LED_AVISO_ACTIVO Verdadero durante 100 ms al inicio de cada 2 s.

activo = mod(max(0, tiempo_s), 2) < 0.1;
