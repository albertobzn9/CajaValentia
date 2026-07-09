function GSB=OA_PreparaSonidosB;


GSB = analogoutput('winsound', 1)
addchannel(GSB, [1 2]);
set(GSB, 'StandardSampleRates','Off')
set(GSB, 'SampleRate', 20000);

fm=20000;
t=(0:1/fm:1)';
sI=1*sin(2*pi*500*t);
sD=1*sin(2*pi*1000*t);
putdata(GSB, [sI sD])
start(GSB);












