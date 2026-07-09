daqreset
handles.OA = OA_ValentiaInicio;


%OA_ValentiaRecompensaI(handles.OA)
%OA_ValentiaRecompensaD(handles.OA)

%OA_ValentiaPalanca(handles.OA,'I',1)
OA_ValentiaPalanca(handles.OA,'D',1)

%OA_ValentiaEstimuloI(handles.OA,0,0)
%OA_ValentiaEstimuloD(handles.OA,0,0)

%OA_ValentiaResetPalancas(handles.OA)

for i=1:10
    pause(1)
[DI,DD]=OA_ValentiaRevisaPalanca(handles.OA)
end