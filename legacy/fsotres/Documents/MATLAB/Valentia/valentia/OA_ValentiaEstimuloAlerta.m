function OA_ValentiaEstimuloAlerta(OA,Lado,Sonido,Luz)
%Lado: I izq, D der
%Luz: 0 apagado, 1  continuo, 2 intermitente.
%Sonido: 0 apagado, 1 continuo, 2 intermitente.


Datos(1:6)=0;
if(strcmp(Lado,'D'))
   if(Sonido==0)
       Datos([1 2 3])=[0 0 0];
   end
   if(Sonido==1)
       Datos([1 2 3])=[1 1 0];
   end
   if(Sonido==2)
       Datos([1 2 3])=[1 0 1];
   end
   if(Luz==0)
       Datos([4 5 6])=[0 0 0];
   end
   if(Luz==1)
       Datos([4 5 6])=[0 1 1];
   end
   if(Luz==2)
       Datos([4 5 6])=[1 0 1];
   end
end
if(strcmp(Lado,'I'))
   if(Sonido==0)
       Datos([1 2 3])=[0 0 0];
   end
   if(Sonido==1)
       Datos([1 2 3])=[0 1 0];
   end
   if(Sonido==2)
       Datos([1 2 3])=[0 0 1];
   end
   if(Luz==0)
       Datos([4 5 6])=[0 0 0];
   end
   if(Luz==1)
       Datos([4 5 6])=[0 1 0];
   end
   if(Luz==2)
       Datos([4 5 6])=[1 0 0];
   end
end


escribePto(OA,[17:22],Datos);
escribePto(OA,[16],1);
escribePto(OA,[16],0);


    