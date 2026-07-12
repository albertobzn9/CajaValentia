function cmc_prueba_planificador_cp_sonido_solo
%CMC_PRUEBA_PLANIFICADOR_CP_SONIDO_SOLO Verifica limites sin caja.

plan = cmc_planificador_cp_sonido_solo(1500, 120, 3);
assert(~plan.ejecutar_sonido);
assert(plan.max_iti_s == 170);

plan = cmc_planificador_cp_sonido_solo(1680, 120, 3);
assert(plan.ejecutar_sonido);

plan = cmc_planificador_cp_sonido_solo(1790, 30, 4);
assert(~plan.finalizar_sin_nuevo_ensayo);
assert(plan.max_iti_s == 10);

plan = cmc_planificador_cp_sonido_solo(1800, 30, 4);
assert(plan.finalizar_sin_nuevo_ensayo);

disp('OK: planificador CP protege el tercer sonido antes del limite.');
