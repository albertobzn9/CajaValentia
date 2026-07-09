function [Secuencia]=OA_SecuenciaEnsayos3(NumRepLado,Riesgo)
%secuencia regresa dos columnas la primera es el lado y la segunda si
%existe electrico
%recibe dos valores (1) NumRepLado indica el numero de repeticiones maximo
%por lado
%(2) Riesgo indica la probablidad de que un ensayo sea con estimulo
%electrico

Secuencia=[];
[Secuencia] = OA_Secuencia(1000,NumRepLado)
%encontramos todos los ensayos donde hay cambio
Secuencia(1,2)=1; %empezamos con ensayo de riesgo
for i=2:1000-1
    if(Secuencia(i-1,1)~=Secuencia(i,1))
        Secuencia(i,2)=1;
    end
end  

iCambio=find(Secuencia(:,2)==1);
[VTR]=OA_ValentiaRiesgo(Riesgo);

Secuencia(iCambio,2)=VTR(1:size(iCambio,1));

