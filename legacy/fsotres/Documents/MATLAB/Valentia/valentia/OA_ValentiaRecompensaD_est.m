function OA_ValentiaRecompensaD_est(OA)

load('C:\Users\fsotres\Documents\MATLAB\Valentia\DatosValentia');

    RD=double(not(RD));
    save('DatosValentia');
    Datos(1:2)=RD;
    control=15;   
enviar=[0 0 0 0 0 0 Datos];
escribePto(OA,[17:24],enviar);
escribePto(OA,[control],1);
escribePto(OA,[control],0);

pause(1)

Datos=[0 0];
enviar=[0 0 0 0 0 0 Datos];
escribePto(OA,[17:24],enviar);
escribePto(OA,[control],1);
escribePto(OA,[control],0);



