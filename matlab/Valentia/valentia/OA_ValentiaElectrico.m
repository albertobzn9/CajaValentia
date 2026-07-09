function OA_ValentiaElectrico(OA,Control)

Datos(1:2)=[0 0];
if(Control==0)
       Datos([1 2])=[0 0];
end

if(Control==1)
       Datos([1 2])=[1 1];
end
escribePto(OA,[13:14],Datos);
pause(.1);

    