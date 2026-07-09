function OA_Sonidos(GS,Duracion,fI,AI,fD,AD);
%esta funcion crea sonido estereo
%OA_Sonidos(GS,Duracion,freqIzq,AmplitudIzq,freqDer,AmplitudDer);
%GS es la tarjeta de sonido
%freq en Hertz
%amp de 0 a 1
%si la frecuencia es mayor a 10 kHz

fm=20000;
t=(0:1/fm:Duracion)';
if(fI<=10000)
sI=AI*sin(2*pi*fI*t);
end
if(fI>10000)
sI=1.5*AI*rand(length(t),1);
end
if(fD<=10000)
sD=AD*sin(2*pi*fD*t);
end
if(fD>10000)
sD=1.5*AD*rand(length(t),1);
end

putdata(GS, [sI sD])
start(GS);











