function [LadoResultado,LatenciaCruce,ContadorTI,ContadorTD,Detenido] = OA_MonitoreaSonidoSolo(OA,Duracion,ContadorTI,ContadorTD,Reloj)
%OA_MONITOREASONIDOSOLO Registra conducta sin terminar ni recompensar.

if nargin < 5
    Reloj = [];
end

OA_ValentiaResetPalancas(OA);
[DI,DD] = OA_ValentiaRevisaPalanca(OA);
DIA = DI;
DDA = DD;
LadoResultado = -2;
LatenciaCruce = Duracion;
Cruzo = 0;
Detenido = 0;
R = tic;

while toc(R) < Duracion
    if ~isempty(Reloj) && ishandle(Reloj)
        set(Reloj, 'String', num2str(toc(R)));
        drawnow;
    end

    PI = OA_ValentiaBuscaIzquierda(OA);
    if PI == 1
        PI = OA_ValentiaBuscaIzquierda(OA);
    end

    PD = OA_ValentiaBuscaDerecha(OA);
    if PD == 1
        PD = OA_ValentiaBuscaDerecha(OA);
    end

    if Cruzo == 0 && PI == 1
        Cruzo = 1;
        LadoResultado = 1;
        LatenciaCruce = toc(R);
    elseif Cruzo == 0 && PD == 1
        Cruzo = 1;
        LadoResultado = 0;
        LatenciaCruce = toc(R);
    end

    [DI,DD] = OA_ValentiaRevisaPalanca(OA);
    if DI ~= DIA
        ContadorTI = ContadorTI + 1;
        DIA = DI;
    end
    if DD ~= DDA
        ContadorTD = ContadorTD + 1;
        DDA = DD;
    end

    load('ControlTarea','CT_Ejecuta');
    if CT_Ejecuta == 0
        Detenido = 1;
        break
    end
    pause(.05);
end
