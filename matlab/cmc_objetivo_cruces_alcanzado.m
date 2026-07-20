function alcanzado = cmc_objetivo_cruces_alcanzado(crucesValidos, objetivo)
%CMC_OBJETIVO_CRUCES_ALCANZADO True when the valid-crossing goal is reached.

alcanzado = crucesValidos >= objetivo;
