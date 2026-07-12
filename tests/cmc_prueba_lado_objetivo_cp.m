function cmc_prueba_lado_objetivo_cp
%CMC_PRUEBA_LADO_OBJETIVO_CP Evita invertir el altavoz del control CP.

assert(cmc_lado_objetivo_cp(0) == 1); % origen derecho -> objetivo izquierdo
assert(cmc_lado_objetivo_cp(1) == 0); % origen izquierdo -> objetivo derecho

fallo = false;
try
    cmc_lado_objetivo_cp(2);
catch
    fallo = true;
end
assert(fallo);
fprintf('OK: CP convierte origen de Secuencia al lado objetivo correcto.\n');
