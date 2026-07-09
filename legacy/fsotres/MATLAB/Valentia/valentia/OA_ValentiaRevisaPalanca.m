function [DI,DD]=OA_ValentiaRevisaPalanca(OA)
%funcion que lee los valores de los contadores de eventos de las palancas
%DI : contador del lado izquierdo
%DD : contador del lado derecho
    escribePto(OA,[9:12],[1 1 0 0]);
    Datos=[getvalue(OA.Line(1:8))];
    a=Datos(1:4);
    DD=bin2dec(strcat(num2str(a(4)),num2str(a(3)),num2str(a(1)),num2str(a(2))));
    a=Datos(5:8);
    DI=bin2dec(strcat(num2str(a(4)),num2str(a(3)),num2str(a(1)),num2str(a(2))));

