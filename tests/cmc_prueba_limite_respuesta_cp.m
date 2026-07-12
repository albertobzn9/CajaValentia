function cmc_prueba_limite_respuesta_cp
%CMC_PRUEBA_LIMITE_RESPUESTA_CP Verifica los 10 s extra de respuesta CP.

assert(cmc_limite_respuesta_cp(30) == 40);
assert(cmc_limite_respuesta_cp(60) == 70);
assert(cmc_limite_respuesta_cp(120) == 130);
fprintf('OK: CP limita la respuesta a duracion mas 10 s.\n');
