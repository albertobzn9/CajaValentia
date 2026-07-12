function OA_ValentiaEstimuloD(OA,Sonido,Luz,varargin)

%Luz: 0 apagado, 1  continuo, 2 intermitente.
%Sonido: 0 apagado, 1 continuo, 2 intermitente.

%el sonido ya no se controla desde esta funcion, lo hace matlab con la
%tarjeta de sonido de la PC.  al quedar libres estas terminales se uso una
%de ellas para prender un led que indica la estimulacion electrica.

PausaLegacy = .3;
if nargin >= 4 && ~isempty(varargin{1})
    PausaLegacy = varargin{1};
end

Datos(1:4)=0;
   if(Sonido==0)
    Datos(1:2)=[0 0];
   end
   if(Sonido==1)
    Datos(1:2)=[1 1];
   end
   if(Sonido==2)
    Datos(1:2)=[1 1];
   end
   
   if(Luz==0)
    Datos(3:4)=[0 0];
   end
   if(Luz==1)
    Datos(3:4)=[1 0];
   end
   if(Luz==2)
    Datos(3:4)=[0 1];
   end
   
   
control=[0 0 0];
CD=[control Datos];  %d
escribePto(OA,17:23,CD);
control=[1 0 0];
CD=[control Datos];  %d y p
escribePto(OA,17:23,CD);
if PausaLegacy > 0
    pause(PausaLegacy);
end
control=[0 0 0];
CD=[control Datos];
escribePto(OA,17:23,CD);  %0p 

