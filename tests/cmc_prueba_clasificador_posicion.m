function cmc_prueba_clasificador_posicion
%CMC_PRUEBA_CLASIFICADOR_POSICION Verifica la clasificacion sin hardware.

base = zeros(1,18);
base([4 9]) = 1;

izquierda = base;
izquierda([1 2 3]) = 1;
centro = base;
centro([10 11 12]) = 1;
derecha = base;
derecha([17 18]) = 1;

assert(strcmp(cmc_clasifica_zona_posicion(izquierda), 'I'));
assert(strcmp(cmc_clasifica_zona_posicion(centro), 'C'));
assert(strcmp(cmc_clasifica_zona_posicion(derecha), 'D'));
assert(strcmp(cmc_clasifica_zona_posicion(base), 'ambigua'));

assert(cmc_es_cruce_valido(0, 'I', 'I', 1.00));
assert(cmc_es_cruce_valido(0, 'D', 'D', 2.30));
assert(~cmc_es_cruce_valido(0, 'C', 'I', 2.30));
assert(~cmc_es_cruce_valido(0, 'I', 'I', .99));
assert(~cmc_es_cruce_valido(1, 'I', 'I', 2.30));

disp('OK: clasificador de posicion sin hardware.');
