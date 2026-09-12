function [ContadorTI,ContadorTD,LatenciaCruce,TiempoEvento,Detenido] = ...
    cmc_ejecutar_sonido_solo_v1(OA,GS,LadoObjetivo,Duracion,Frecuencia, ...
    Reloj,ContadorTI,ContadorTD)
%CMC_EJECUTAR_SONIDO_SOLO_V1 Sonido, LED rojo y parrilla; nunca comida.

OA_ValentiaResetPalancas(OA);
[DIA,DDA] = OA_ValentiaRevisaPalanca(OA);
LatenciaCruce = Duracion;
Cruzo = false;
Detenido = false;
limpieza = onCleanup(@() cmc_apagar_sonido_solo_v1(OA,GS));

if LadoObjetivo == 1
    OA_Sonidos(GS,Duracion+1,Frecuencia,1,0,0);
else
    OA_Sonidos(GS,Duracion+1,0,0,Frecuencia,1);
end
OA_ValentiaEstimuloD(OA,2,0);
OA_ValentiaElectrico(OA,1);
InicioEvento = tic;

while toc(InicioEvento) < Duracion
    if ishandle(Reloj)
        set(Reloj,'String',num2str(toc(InicioEvento)));
    end
    drawnow;
    if ~ishandle(Reloj)
        error('CMC:VentanaCerradaSonido', ...
            'La ventana se cerro durante el control de sonido.');
    end

    if ~Cruzo
        if LadoObjetivo == 1
            P = OA_ValentiaBuscaIzquierda(OA);
            if P == 1
                P = OA_ValentiaBuscaIzquierda(OA);
            end
        else
            P = OA_ValentiaBuscaDerecha(OA);
        end
        if P == 1
            Cruzo = true;
            LatenciaCruce = toc(InicioEvento);
        end
    end

    [DI,DD] = OA_ValentiaRevisaPalanca(OA);
    if DI ~= DIA
        ContadorTI = ContadorTI+1;
    end
    if DD ~= DDA
        ContadorTD = ContadorTD+1;
    end
    DIA = DI;
    DDA = DD;
    estado = load(fullfile(cmc_state_dir(),'ControlTarea'),'CT_Ejecuta');
    if estado.CT_Ejecuta == 0
        Detenido = true;
        break
    end
    pause(.05);
end

TiempoEvento = toc(InicioEvento);
end


function cmc_apagar_sonido_solo_v1(OA,GS)
try
    OA_ValentiaElectrico(OA,0);
catch ME
    warning('CMC:ParrillaSonidoSolo', ...
        'No se pudo apagar la parrilla: %s',ME.message);
end
try
    OA_ValentiaEstimuloD(OA,0,0);
catch ME
    warning('CMC:LedSonidoSolo', ...
        'No se pudo apagar el LED rojo: %s',ME.message);
end
try
    stop(GS);
catch ME
    warning('CMC:AudioSonidoSolo', ...
        'No se pudo detener el sonido: %s',ME.message);
end
end
