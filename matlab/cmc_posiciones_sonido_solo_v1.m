function ProgramarSonido = cmc_posiciones_sonido_solo_v1(NumEnsayos,Riesgo)
%CMC_POSICIONES_SONIDO_SOLO_V1 Un control por cada diez ensayos normales.

ProgramarSonido = false(NumEnsayos,1);
if Riesgo <= 0
    return
end

NumBloques = floor(NumEnsayos/10);
for Bloque = 1:NumBloques
    Indice = (Bloque-1)*10 + floor(10*rand(1,1)) + 1;
    ProgramarSonido(Indice) = true;
end
end
