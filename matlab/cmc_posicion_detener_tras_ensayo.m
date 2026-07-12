function posicion = cmc_posicion_detener_tras_ensayo(posicionDetenerAhora)
%CMC_POSICION_DETENER_TRAS_ENSAYO Ubica el boton en el hueco del .fig CP.

posicion = posicionDetenerAhora;
posicion(2) = posicionDetenerAhora(2) + posicionDetenerAhora(4) + .5;
