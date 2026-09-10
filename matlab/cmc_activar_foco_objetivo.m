function Ordenes = cmc_activar_foco_objetivo(OA,LadoObjetivo,TipoEvento,ActivarLuz)
%CMC_ACTIVAR_FOCO_OBJETIVO Aplica un estado exclusivo de luz de comida.

Ordenes = cmc_plan_foco_objetivo(LadoObjetivo,TipoEvento,ActivarLuz);
for i = 1:length(Ordenes)
    Orden = Ordenes(i);
    if strcmp(Orden.Lado,'I')
        OA_ValentiaEstimuloI(OA,Orden.Sonido,Orden.Luz);
    else
        OA_ValentiaEstimuloD(OA,Orden.Sonido,Orden.Luz);
    end
end
end
