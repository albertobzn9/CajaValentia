function cantidad = cmc_cuenta_ensayos_cruce_programados(Secuencia)
%CMC_CUENTA_ENSAYOS_CRUCE_PROGRAMADOS Cuenta requisitos en una secuencia.

cantidad = 0;
for i = 1:size(Secuencia,1)
    ensayoMismoLado = 0;
    if i > 1 && Secuencia(i-1,1) == Secuencia(i,1)
        ensayoMismoLado = 1;
    end
    if cmc_es_ensayo_cruce_programado(ensayoMismoLado,Secuencia(i,2))
        cantidad = cantidad + 1;
    end
end
