function [Secuencia]=OA_SecuenciaEnsayosRepetidos(Aleatorio,Riesgo,Rept)
%secuencia regresa dos columnas la primera es el lado y la segunda si
%existe electrico
%recibe dos valores (Aleatorio: 1 secuencia completamente aleatoria,
%0:secuencia alternando lado derecho y lado izquierdo.
%el otro valor indica la probablidad de que un ensayo sea con estimulo
%electrico

Secuencia=[];

if(Aleatorio==0)
    inicio=(rand(1,1));
    Secuencia(1,1)=0;
    if(inicio>0.5)
        Secuencia(1,1)=1;
    end    
    for i=2:500
        Secuencia(i,1)=not(Secuencia(i-1,1));
    end
end    
if(Aleatorio==1)
    aleat=rand(1,Rept);
    aleat=aleat>0.5;
    Secuencia(1:Rept,1)=aleat
    %revisamos que no sucedan secuencias largas
    for i=Rept+1:500
        i
        iIG=find(Secuencia(i-2:i-Rept,1)==Secuencia(i-1,1))
        if(size(iIG,1)==Rept)
            Secuencia(i,1)=not(Secuencia(i-1,1));
        end    
        
        if(size(iIG,1)<Rept)
            Secuencia(i,1)=not(Secuencia(i-1,1));
        end 
        Secuencia
        pause
     end    
end    

%encontramos todos los ensayos donde hay cambio
Secuencia(1,2)=1;
for i=2:500-1
    if(Secuencia(i-1,1)~=Secuencia(i,1))
        Secuencia(i,2)=1;
    end
end  

iCambio=find(Secuencia(:,2)==1);
[VTR]=OA_ValentiaRiesgo(Riesgo);

Secuencia(iCambio,2)=VTR(1:size(iCambio,1));