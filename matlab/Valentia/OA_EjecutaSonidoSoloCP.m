function [Fila,ContadorTI,ContadorTD,Detenido] = OA_EjecutaSonidoSoloCP(handles,LadoObjetivo,Duracion,freqRiesgo,NumeroEvento,R0,ContadorTI,ContadorTD)
%OA_EJECUTASONIDOSOLOCP Ejecuta un evento CP sin luz ni recompensa.
% El evento dura completo, aunque la rata cruce o presione una palanca.

if LadoObjetivo == 1
    OA_Sonidos(handles.GS,Duracion+1,freqRiesgo,1,0,0);
else
    OA_Sonidos(handles.GS,Duracion+1,0,0,freqRiesgo,1);
end

% El LED rojo es el marcador visible del ruido blanco en los videos.
OA_ValentiaEstimuloD(handles.OA,2,0);
pause(.1);
OA_ValentiaElectrico(handles.OA,1);

[LadoResultado,LatenciaCruce,ContadorTI,ContadorTD,Detenido] = ...
    OA_MonitoreaSonidoSolo(handles.OA,Duracion,ContadorTI,ContadorTD,handles.edit9);

% Columna 4: duracion completa del evento. Columna 8: primer cruce, o
% Duracion si no hubo cruce. Columna 9 identifica sonido solo.
Fila=[NumeroEvento LadoResultado 1 Duracion toc(R0) ...
    ContadorTI ContadorTD LatenciaCruce 2];

OA_ValentiaElectrico(handles.OA,0);
OA_ValentiaEstimuloI(handles.OA,0,0);
OA_ValentiaEstimuloD(handles.OA,0,0);
stop(handles.GS);
