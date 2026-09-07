function cuenta = cmc_es_ensayo_cruce_programado(ensayoMismoLado, tipoEvento)
%CMC_ES_ENSAYO_CRUCE_PROGRAMADO Clasifica el requisito del evento.
% Un ensayo con comida cuenta si exige cambiar de lado, aunque la rata no
% cruce antes del limite. Mismo lado y sonido solo no cuentan.

cuenta = tipoEvento ~= 2 && ensayoMismoLado == 0;
