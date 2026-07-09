function [pos, DatosL]=OA_ValentiaPosicionExtrema(OA)
%regresa el valor de los veinte sensores
tic
DatosL=[];
escribePto(OA,[9:16],[0 0 0 0 0 0 0 0]);
DatosL=[getvalue(OA.Line(1:8))];
DatosL=not(DatosL);
pos=find(DatosL==1);
toc





