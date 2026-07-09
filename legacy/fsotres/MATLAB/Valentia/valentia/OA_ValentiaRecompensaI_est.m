function OA_ValentiaRecompensaI_est(OA,Sonido,Luz)
%Al llamar a esta funcion se activa el motor para dar recompensa
%se debe mandar tambien el estado del sonido y luz izquierdas

   if(Sonido==0)
       DatosE([1 2 3])=[0 0 0];
   end
   if(Sonido==1)
       DatosE([1 2 3])=[0 1 0];
   end
   if(Sonido==2)
       DatosE([1 2 3])=[0 0 1];
   end
   if(Luz==0)
       DatosE([4 5 6])=[0 0 0];
   end
   if(Luz==1)
       DatosE([4 5 6])=[0 1 0];
   end
   if(Luz==2)
       DatosE([4 5 6])=[1 0 0];
   end
   
DatosE;
load('c:DatosValentia');

    RI=double(not(RI));
    save('c:DatosValentia','RD','RI');
    DatosE(7:8)=RI;
    control=16;   
escribePto(OA,[17:24],DatosE);
escribePto(OA,[control],1);
escribePto(OA,[control],0);
pause(1)
DatosE(7:8)=[0 0];
escribePto(OA,[17:24],DatosE);
escribePto(OA,[control],1);
escribePto(OA,[control],0);
DatosE;


