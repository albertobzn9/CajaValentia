function [P]=OA_ValentiaBuscaIzquierda(OA)
%regresa el valor de los sensores de la extrema derecha
DatosL=[];
escribePto(OA,[9:12],[0 1 0 0]);
DatosL=[getvalue(OA.Line(1:8))];
DD=not(DatosL(1:3))';
PV=find(DD==1);
P=0;
if(size(PV,1)>0)
    P=1;
end    









