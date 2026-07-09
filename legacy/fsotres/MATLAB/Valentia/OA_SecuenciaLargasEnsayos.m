function [Secuencia]=OA_SecuenciaLargasEnsayos(Aleatorio,Riesgo,Largas)
%secuencia regresa dos columnas la primera es el lado y la segunda si
%existe electrico
%recibe dos valores (Aleatorio: 1 secuencia completamente aleatoria,
%0:secuencia alternando lado derecho y lado izquierdo.
%el otro valor indica la probablidad de que un ensayo sea con estimulo
%electrico

a=[];
[archSec,path]=uigetfile('Sec*.mat');

try
load(strcat(path,archSec));
catch
end    
if(size(a,1)>0)
    Secuencia=a;
end    




if(size(a,1)<=0)

Secuencia=[];

if(Aleatorio==0)
    inicio=(rand(1,1));
    Secuencia(1,1)=0;
    if(inicio>0.5)
        Secuencia(1,1)=1;
    end    
    for i=2:100
        Secuencia(i,1)=not(Secuencia(i-1,1));
    end
end    
if(Aleatorio==1)
    aleat=rand(1,2);
    aleat=aleat>0.5;
    Secuencia(1:2,1)=aleat;
    %revisamos que no sucedan secuencias largas
    if(Largas==0)
    for i=3:100
        if(Secuencia(i-2,1)==Secuencia(i-1,1))
            Secuencia(i,1)=not(Secuencia(i-1,1));
        end
        if(Secuencia(i-2,1)~=Secuencia(i-1,1))
            aleat=rand(1,1);
            Secuencia(i,1)=0;
            if(aleat>0.5)
                Secuencia(i,1)=1;
            end 
        end 
    end  
    end
    
    if(Largas==1)
            aleat=rand(100,1);
            aleat=aleat>0.5;
            Secuencia(1:100,1)=aleat;
            Secuencia(1:100,2)=0;
    end   
    
end    
    
end    

%encontramos todos los ensayos donde hay cambio
Secuencia(1,2)=1;
for i=2:100-1
    if(Secuencia(i-1,1)~=Secuencia(i,1))
        Secuencia(i,2)=1;
    end
end  

iCambio=find(Secuencia(:,2)==1);
[VTR]=OA_ValentiaRiesgo(Riesgo);

Secuencia(iCambio,2)=VTR(1:size(iCambio,1));