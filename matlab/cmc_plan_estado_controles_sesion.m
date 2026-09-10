function Plan = cmc_plan_estado_controles_sesion(Estado)
%CMC_PLAN_ESTADO_CONTROLES_SESION Define texto y bloqueo de botones.

Plan.Inicio = struct('String','Inicio','Enable','off');
Plan.DetenerAhora = struct('String','Detener ahora','Enable','off');
Plan.DetenerTrasEnsayo = struct( ...
    'String','Detener tras ensayo','Enable','off');

switch Estado
    case 'listo'
        Plan.Inicio.Enable = 'on';
    case 'habituacion_inicial'
        Plan.Inicio.String = 'Habituacion inicial';
        Plan.DetenerAhora.Enable = 'on';
    case 'ensayos'
        Plan.Inicio.String = 'Ejecutando';
        Plan.DetenerAhora.Enable = 'on';
        Plan.DetenerTrasEnsayo.Enable = 'on';
    case 'detencion_tras_ensayo'
        Plan.Inicio.String = 'Ejecutando';
        Plan.DetenerAhora.Enable = 'on';
        Plan.DetenerTrasEnsayo.String = 'Detencion solicitada';
    case 'detencion_inmediata'
        Plan.Inicio.String = 'Deteniendo';
    case 'finalizando'
        Plan.Inicio.String = 'Finalizando';
    case 'error'
        Plan.Inicio.String = 'Error: cerrar';
    otherwise
        error('CMC:EstadoControlesSesion', ...
            'Estado de controles desconocido: %s',Estado);
end
end
