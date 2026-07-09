function [Secuencia] = OA_Secuencia(TamSec,MaxR)
a=randn(10000,1);
in=find(a>=0);
a(in)=-a(in);
a=MaxR+ceil(a.*MaxR);
ia=find((a>0)&(a<=(MaxR)));
a=a(ia);
Secuencia=[];
valor=round(rand(1,1));
i=0;
while(size(Secuencia,1)<TamSec)
    valor=not(valor);
    i=i+1;
    if(valor==1)
        Secuencia=[Secuencia;ones(a(i),1)];
    end
    if(valor==0)
        Secuencia=[Secuencia;zeros(a(i),1)];
    end
end

Secuencia=Secuencia(1:TamSec,1);

