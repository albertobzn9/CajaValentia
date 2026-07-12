function cmc_prueba_ensayos_terminados
%CMC_PRUEBA_ENSAYOS_TERMINADOS Prueba el contador sin hardware.

Resultados = [ ...
    1  1 0 2.1 10 0 1 1.4 0; ...
    2 -2 0 20  35 0 1 20  0; ...
    3  0 1 180 220 1 1 4.2 2];

assert(cmc_ensayos_terminados(Resultados) == 3);
assert(cmc_ensayos_terminados(zeros(0,9)) == 0);
disp('OK: ensayos terminados incluye cruce, no-cruce y sonido solo.');
