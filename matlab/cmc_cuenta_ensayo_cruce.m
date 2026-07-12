function cuenta = cmc_cuenta_ensayo_cruce(ensayoMismoLado, zonaInicio, ladoProgramado, desplazamiento, huboCruce)
%CMC_CUENTA_ENSAYO_CRUCE Decide si un evento cuenta hacia el objetivo.
% Un no-cruce cuenta si la rata estaba lateralizada y el ensayo exigia cambiar
% de lado. Asi una rata miedosa puede completar la sesion. Los inicios desde
% el centro y las repeticiones del mismo lado no cuentan.

if huboCruce
    cuenta = cmc_es_cruce_valido(ensayoMismoLado, zonaInicio, ...
        ladoProgramado, desplazamiento);
else
    cuenta = ensayoMismoLado == 0 && strcmp(zonaInicio, ladoProgramado);
end
end
