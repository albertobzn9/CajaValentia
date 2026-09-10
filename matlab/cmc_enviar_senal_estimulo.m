function cmc_enviar_senal_estimulo(OA,ControlActivo,Sonido,Luz,PausaPulso,PausaEstabilizacion)
%CMC_ENVIAR_SENAL_ESTIMULO Envia datos, pulso y cierre al bus de estimulos.

[Tramas,Pausas] = cmc_plan_senal_estimulo( ...
    ControlActivo,Sonido,Luz,PausaPulso,PausaEstabilizacion);

for i = 1:size(Tramas,1)
    escribePto(OA,17:23,Tramas(i,:));
    if Pausas(i) > 0
        pause(Pausas(i));
    end
end
end
