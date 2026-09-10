function Ordenes = cmc_plan_foco_objetivo(LadoObjetivo,TipoEvento,ActivarLuz)
%CMC_PLAN_FOCO_OBJETIVO Apaga el opuesto antes de fijar el foco objetivo.

if ~ischar(LadoObjetivo) || ...
        ~(strcmp(LadoObjetivo,'I') || strcmp(LadoObjetivo,'D'))
    error('CMC:LadoObjetivo', 'LadoObjetivo debe ser I o D.');
end
if numel(TipoEvento) ~= 1 || ~any(TipoEvento == [0 1])
    error('CMC:TipoEventoFoco', ...
        'Los focos de comida solo aceptan TipoEvento 0 o 1.');
end
if numel(ActivarLuz) ~= 1 || ~any(ActivarLuz == [0 1])
    error('CMC:ActivarLuz', 'ActivarLuz debe ser 0 o 1.');
end

Marcador = 2 * (TipoEvento == 1);
if strcmp(LadoObjetivo,'I')
    Ordenes(1) = struct('Lado','D','Sonido',Marcador,'Luz',0);
    Ordenes(2) = struct('Lado','I','Sonido',0,'Luz',ActivarLuz);
else
    Ordenes(1) = struct('Lado','I','Sonido',0,'Luz',0);
    Ordenes(2) = struct('Lado','D','Sonido',Marcador,'Luz',ActivarLuz);
end
end
