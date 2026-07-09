function [Secuencia]=OA_SecuenciaEnsayosConflicto(NumRepLado,Riesgo,Conflicto)
%secuencia regresa dos columnas la primera es el lado y la segunda si
%existe electrico
%recibe dos valores (1) NumRepLado indica el numero de repeticiones maximo
%por lado
%(2) Riesgo indica la probablidad de que un ensayo sea con estimulo
%electrico

Secuencia=[];
[Secuencia] = OA_Secuencia(1300,NumRepLado)
%encontramos todos los ensayos donde hay cambio
Secuencia(1,2)=0; %empezamos con ensayo seguro
for i=2:1300-1
    if(Secuencia(i-1,1)~=Secuencia(i,1))
        Secuencia(i,2)=1;
    end
end  

iCambio=find(Secuencia(:,2)==1);
[VTR]=OA_ValentiaRiesgoConflicto(Riesgo,Conflicto);

Secuencia(iCambio,2)=VTR(1:size(iCambio,1));

Secuencia(1:30,:)