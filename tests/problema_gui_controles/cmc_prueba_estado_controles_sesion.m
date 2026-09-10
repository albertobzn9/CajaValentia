function cmc_prueba_estado_controles_sesion
%CMC_PRUEBA_ESTADO_CONTROLES_SESION Valida botones sin cargar hardware.

cmc_verifica_plan('listo','on','off','off','Inicio');
cmc_verifica_plan('habituacion_inicial','off','on','off', ...
    'Habituacion inicial');
cmc_verifica_plan('ensayos','off','on','on','Ejecutando');
cmc_verifica_plan('detencion_tras_ensayo','off','on','off','Ejecutando');
cmc_verifica_plan('detencion_inmediata','off','off','off','Deteniendo');
cmc_verifica_plan('finalizando','off','off','off','Finalizando');
cmc_verifica_plan('error','off','off','off','Error: cerrar');
cmc_verifica_controles_reales;
disp('OK: estados de botones de sesion validados sin hardware.');
end


function cmc_verifica_plan(Estado,Inicio,DetenerAhora,DetenerTras,TextoInicio)
Plan = cmc_plan_estado_controles_sesion(Estado);
assert(strcmp(Plan.Inicio.Enable,Inicio));
assert(strcmp(Plan.DetenerAhora.Enable,DetenerAhora));
assert(strcmp(Plan.DetenerTrasEnsayo.Enable,DetenerTras));
assert(strcmp(Plan.Inicio.String,TextoInicio));
end


function cmc_verifica_controles_reales
Figura = figure('Visible','off');
Limpieza = onCleanup(@() delete(Figura));
handles.figure1 = Figura;
handles.Inicio = uicontrol('Parent',Figura,'Style','pushbutton');
handles.Terminarn2 = uicontrol('Parent',Figura,'Style','pushbutton');
handles.DetenerTrasEnsayo = uicontrol('Parent',Figura,'Style','pushbutton');

cmc_aplicar_estado_controles_sesion(handles,'ensayos');
assert(strcmp(get(handles.Inicio,'Enable'),'off'));
assert(strcmp(get(handles.Terminarn2,'Enable'),'on'));
assert(strcmp(get(handles.DetenerTrasEnsayo,'Enable'),'on'));
assert(strcmp(getappdata(Figura,'CMCEstadoSesion'),'ensayos'));

cmc_aplicar_estado_controles_sesion(handles,'listo');
assert(strcmp(get(handles.Inicio,'Enable'),'on'));
assert(strcmp(get(handles.Terminarn2,'Enable'),'off'));
assert(strcmp(get(handles.DetenerTrasEnsayo,'Enable'),'off'));
end
