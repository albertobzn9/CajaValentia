function [Secuencia]=OA_SecuenciaEnsayos5(NumRepLado,Riesgo,Neutros)
%secuencia regresa dos columnas la primera es el lado y la segunda si
%existe electrico
%recibe dos valores (1) NumRepLado indica el numero de repeticiones maximo
%por lado
%(2) Riesgo indica la probablidad de que un ensayo sea con estimulo
%electrico
%(3) Porcentaje de ensayos neutros

Secuencia=[];
[Secuencia] = OA_Secuencia(1000,NumRepLado)
%encontramos todos los ensayos donde hay cambio
Secuencia(1,2)=0; %empezamos con ensayo  seguro
for i=2:1000-1
    if(Secuencia(i-1,1)~=Secuencia(i,1))
        Secuencia(i,2)=1;
    end
end  

iCambio=find(Secuencia(:,2)==1);
[VTR]=OA_ValentiaRiesgoMasNeutros(Riesgo,Neutros);

Secuencia(iCambio,2)=VTR(1:size(iCambio,1));

