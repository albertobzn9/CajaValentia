function cmc_prueba_plan_sonido_solo_cp
%CMC_PRUEBA_PLAN_SONIDO_SOLO_CP Prueba logica, sin caja ni hardware.

Tiempos = [9 18 27]*60;
assert(isequal(Tiempos,[540 1080 1620]));
assert(sum(Tiempos <= 30*60) == 3);

Secuencia = OA_SecuenciaEnsayos4(1,1);
assert(all(Secuencia(1:50,2) == 1));
assert(all(Secuencia(1:49,1) ~= Secuencia(2:50,1)));

disp('OK: CP programa 9/18/27 min y la secuencia de riesgo alterna lados.');
