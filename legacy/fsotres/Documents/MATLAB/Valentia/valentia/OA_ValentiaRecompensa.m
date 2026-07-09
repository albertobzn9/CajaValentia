function OA_ValentiaRecompensaD(OA)

load('c:DatosValentia');

    RD=double(not(RD));
    save('c:DatosValentia');
    Datos(1:2)=RD;
    control=15;   

escribePto(OA,[23:24],Datos);
escribePto(OA,[control],1);
escribePto(OA,[control],0);

pause(2)

Datos=[0 0];
escribePto(OA,[23:24],Datos);
escribePto(OA,[control],1);
escribePto(OA,[control],0);



