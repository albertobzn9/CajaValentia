function GS=OA_PreparaSonidos;


GS = analogoutput('winsound', 0);
addchannel(GS, [1 2]);
set(GS, 'StandardSampleRates','Off')
set(GS, 'SampleRate', 20000);












