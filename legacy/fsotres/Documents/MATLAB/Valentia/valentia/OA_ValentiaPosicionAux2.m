function [pos, DatosL]=OA_ValentiaPosicionAux2(OA)
%regresa el valor de los veinte sensores

DatosL=[];
escribePto(OA,[9:16],[0 0 0 0 0 0 0 0]);
%pause(.01)
DatosL=[DatosL getvalue(OA.Line(1:8))];
escribePto(OA,[9:16],[1 0 0 0 0 0 0 0]);
%pause(.01)
DatosL=[DatosL getvalue(OA.Line(1:8))];
escribePto(OA,[9:16],[0 1 0 0 0 0 0 0]);
%pause(.01)
DatosL=[DatosL getvalue(OA.Line(1:8))];
DatosL=not(DatosL);
DatosL=fliplr(DatosL);
DatosL=DatosL(6:23);
pos=find(DatosL==1);





