function GSA=OA_PreparaSonidosA;


GSA = analogoutput('winsound', 0);
addchannel(GSA, [1 2]);
set(GSA, 'StandardSampleRates','Off')
set(GSA, 'SampleRate', 20000);












