function OA_FinSonidos(GS,Duracion,fI,AI,fD,AD);
%esta funcion crea sonido estereo
%OA_Sonidos(GS,Duracion,freqIzq,AmplitudIzq,freqDer,AmplitudDer);
%GS es la tarjeta de sonido
%freq en Hertz
%amp de 0 a 1
%si la frecuencia es mayor a 10 kHz

GS.playSamples(CMCGeneraSonido(Duracion,fI,AI,fD,AD,1));











