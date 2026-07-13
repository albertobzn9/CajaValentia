function OA_ValentiaPalanca(OA,Lado,Sentido)
%Funcion OA_ValentiaPalanca
%Desplaza la palanca hasta mostrarla u ocultarla
%Lado: 'I'  izquierdo, 'D'  derecho
%Sentido: 0 apagar, 1 mostrar, 2 ocultar 

Datos(1:4)=0;
if(strcmp(Lado,'D'))
   if(Sentido==1)
    Datos(3:4)=[0 1];
   end
   if(Sentido==2)
    Datos(3:4)=[1 0];
   end
control=[0 0 0];
CD=[control Datos];  %d
escribePto(OA,17:23,CD);
control=[0 1 0];
CD=[control Datos];  %d y p
escribePto(OA,17:23,CD);
pause(1); %2
Datos=[0 0 0 0];
control=[0 0 0];
CD=[control Datos];
escribePto(OA,17:23,CD); %0
control=[0 1 0];
CD=[control Datos];
escribePto(OA,17:23,CD); %p0
control=[0 0 0];
CD=[control Datos];
escribePto(OA,17:23,CD);   
end




if(strcmp(Lado,'I'))
   if(Sentido==1)
    Datos(3:4)=[1 0];
   end
   if(Sentido==2)
    Datos(3:4)=[0 1];
   end
control=[0 0 0];
CD=[control Datos];  %d
escribePto(OA,17:23,CD);
control=[0 0 1];
CD=[control Datos];  %d y p
escribePto(OA,17:23,CD);
pause(1); %2
Datos=[0 0 0 0];
control=[0 0 0];
CD=[control Datos];
escribePto(OA,17:23,CD); %0
control=[0 0 1];
CD=[control Datos];
escribePto(OA,17:23,CD); %p0
control=[0 0 0];
CD=[control Datos];
escribePto(OA,17:23,CD);      
   
end


