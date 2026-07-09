function [VTR]=OA_ValentiaRiesgoNeutros(Riesgo,Neutros)
%esta funcion regresa 1000 datos con ceros y unos dependiendo del
%valor de riesgo, los datos estan agrupados de 10 en 10
VTR=[];
for iRE=1:100
        VR=[];
        fR=round(Riesgo*10);
        fN=round(Neutros*10);
        VR(1:10,1)=0;
        VR(1:fR,1)=1;
        VR(fR+1:fR+fN,1)=3;
        VTR=[VTR;VR(randperm(10))];
end  




