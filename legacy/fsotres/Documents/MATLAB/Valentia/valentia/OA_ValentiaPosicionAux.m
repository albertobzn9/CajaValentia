function [Lado]=OA_ValentiaPosicionAux(OA)
%regresa el valor de los veinte sensores
DatosL=[];


escribePto(OA,[9:16],[1 0 0 0 0 0 0 0]);
pause(.01)
DatosL=[DatosL getvalue(OA.Line(1:8))];
escribePto(OA,[9:16],[0 1 0 0 0 0 0 0]);
pause(.01)
DatosL=[DatosL getvalue(OA.Line(1:8))];
DatosL=not(DatosL(3:11));
DatosL=fliplr(DatosL);
donde=[];
donde=find(DatosL==1);


Lado='D';

if(donde>0)
    Lado='I';
end



