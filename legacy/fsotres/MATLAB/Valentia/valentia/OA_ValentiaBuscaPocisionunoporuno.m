function [P]=OA_ValentiaBuscaPocisionunoporuno(OA)
%regresa el valor de los sensores de la extrema derecha
DatosL=[];
escribePto(OA,[9:12],[0 1 0 0]);
DatosL=[getvalue(OA.Line(1:8))]
DD=not(DatosL(2:4))';
PV=find(DD==1);
P=0;
if(size(PV,1)>0)
    P=1;
end    









