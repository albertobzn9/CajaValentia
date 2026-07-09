function [Lugar,Lado,P]=OA_ValentiaPosicion(OA)
%regresa el valor de los veinte sensores
Datos=[];


% escribePto(OA,[9:12],[0 0 0 0]);
% Datos=[Datos getvalue(OA.Line(1:8))];
Datos=[1 1 1 1 1 1 1 1];
escribePto(OA,[9:12],[1 0 0 0]);
Datos=[Datos getvalue(OA.Line(1:8))];
escribePto(OA,[9:12],[0 1 0 0]);
Datos=[Datos getvalue(OA.Line(1:8))];
Datos=not(Datos(2:19))
Datos=fliplr(Datos);
donde=[];
donde=find(Datos==1);
dD=find(donde>=9);
dI=find(donde<9);
if(size(dI,2)>=size(dD,2))
    Lado='I';
end
if(size(dI,2)<size(dD,2))
    Lado='D';
end
Lugar=Datos;
P=mean(donde);



