function Samples = CMCGeneraSonido(Duracion,fI,AI,fD,AD,FactorRuido)
%CMCGENERASONIDO Crea sonido estereo sin reproducirlo.

FrecuenciaMuestreo = 20000;
Tiempo = (0:1/FrecuenciaMuestreo:Duracion)';

if fI <= 10000
    Izquierdo = AI*sin(2*pi*fI*Tiempo);
else
    Izquierdo = FactorRuido*AI*rand(length(Tiempo),1);
end

if fD <= 10000
    Derecho = AD*sin(2*pi*fD*Tiempo);
else
    Derecho = FactorRuido*AD*rand(length(Tiempo),1);
end

Samples = [Izquierdo Derecho];
