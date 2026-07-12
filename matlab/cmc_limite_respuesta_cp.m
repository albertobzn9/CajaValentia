function limite = cmc_limite_respuesta_cp(duracionEnsayo)
%CMC_LIMITE_RESPUESTA_CP Da 10 s extra para palanquear despues del cruce.
% El limite se mide desde el inicio del ensayo, no desde que la rata cruza.

if ~(isscalar(duracionEnsayo) && isfinite(duracionEnsayo) && duracionEnsayo > 0)
    error('CajaValentia:DuracionCP', 'La duracion CP debe ser positiva.');
end
limite = duracionEnsayo + 10;
