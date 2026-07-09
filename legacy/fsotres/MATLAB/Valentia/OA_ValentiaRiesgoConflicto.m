function [VTR]=OA_ValentiaRiesgoConflicto(Riesgo,Conflicto)
%esta funcion regresa 1000 datos con ceros y unos dependiendo del
%valor de riesgo, los datos estan agrupados de 10 en 10
VTR=[];
for iRE=1:100
        VR=[];
        fR=round(Riesgo*10);
        fC=round(Conflicto*10);
        VR(1:10,1)=0;
        VR(1:fR,1)=1;
        VR(fR+1:fR+fC,1)=3;
        VTR=[VTR;VR(randperm(10))];
end  




