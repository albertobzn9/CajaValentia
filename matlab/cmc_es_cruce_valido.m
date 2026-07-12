function valido = cmc_es_cruce_valido(ensayoMismoLado, zonaInicio, ladoProgramado, desplazamiento)
%CMC_ES_CRUCE_VALIDO Decide si una llegada debe contar como cruce real.
% La regla replica el analisis posterior: cambio de lado, posicion inicial
% lateral confirmada y desplazamiento de al menos un segundo.

valido = ensayoMismoLado == 0 && ...
    strcmp(zonaInicio, ladoProgramado) && ...
    ~isempty(desplazamiento) && desplazamiento >= 1;
