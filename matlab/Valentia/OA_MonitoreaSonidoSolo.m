function [LadoResultado,LatenciaCruce,ContadorTI,ContadorTD,Detenido,EstadoPalanqueos,EventosPalanqueo] = ...
    OA_MonitoreaSonidoSolo(OA,Duracion,ContadorTI,ContadorTD,Reloj,EstadoPalanqueos,EventosPalanqueo,R0,NumeroEnsayo)
%OA_MONITOREASONIDOSOLO Registra conducta sin terminar ni recompensar.

if nargin < 5
    Reloj = [];
end
RegistrarPalanqueos = nargin >= 9;
if RegistrarPalanqueos == 0
    EstadoPalanqueos = [];
    EventosPalanqueo = [];
end

OA_ValentiaResetPalancas(OA);
[DI,DD] = OA_ValentiaRevisaPalanca(OA);
DIA = DI;
DDA = DD;
if RegistrarPalanqueos == 1
    EstadoPalanqueos = cmc_reiniciar_referencia_palanqueos(EstadoPalanqueos,DI,DD);
end
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
    if RegistrarPalanqueos == 1
        [EstadoPalanqueos,EventosPalanqueo,NuevaI,NuevaD] = cmc_registrar_palanqueos( ...
            EstadoPalanqueos,EventosPalanqueo,DI,DD,toc(R0), ...
            'ensayo',NumeroEnsayo,'sonido_solo');
        ContadorTI = ContadorTI + NuevaI;
        ContadorTD = ContadorTD + NuevaD;
    else
        if DI ~= DIA
            ContadorTI = ContadorTI + 1;
            DIA = DI;
        end
        if DD ~= DDA
            ContadorTD = ContadorTD + 1;
            DDA = DD;
        end
    end

    load('ControlTarea','CT_Ejecuta');
    if CT_Ejecuta == 0
        Detenido = 1;
        break
    end
    pause(.05);
end
