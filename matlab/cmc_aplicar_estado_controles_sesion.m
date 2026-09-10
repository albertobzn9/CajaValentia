function cmc_aplicar_estado_controles_sesion(handles,Estado)
%CMC_APLICAR_ESTADO_CONTROLES_SESION Actualiza los botones de la tarea.

Plan = cmc_plan_estado_controles_sesion(Estado);
cmc_aplicar_control_sesion(handles,'Inicio',Plan.Inicio);
cmc_aplicar_control_sesion(handles,'Terminarn2',Plan.DetenerAhora);
cmc_aplicar_control_sesion( ...
    handles,'DetenerTrasEnsayo',Plan.DetenerTrasEnsayo);

if isfield(handles,'figure1') && ishandle(handles.figure1)
    setappdata(handles.figure1,'CMCEstadoSesion',Estado);
end
end


function cmc_aplicar_control_sesion(handles,Nombre,EstadoControl)
if ~isfield(handles,Nombre) || ~ishandle(handles.(Nombre))
    return
end
set(handles.(Nombre),'String',EstadoControl.String, ...
    'Enable',EstadoControl.Enable);
end
