function estado = cmc_reiniciar_referencia_palanqueos(estado, izq, der)
%CMC_REINICIAR_REFERENCIA_PALANQUEOS Fija la referencia despues de un reset.

estado.izq = izq;
estado.der = der;
estado.inicializado = 1;
