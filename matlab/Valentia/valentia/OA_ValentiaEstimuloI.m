function OA_ValentiaEstimuloI(OA,Sonido,Luz)

%Luz: 0 apagado, 1 continuo, 2 intermitente.
%Sonido: 0 apagado, 1 continuo, 2 intermitente.

% El sonido ya no se controla desde esta funcion. Sus bits se reutilizan
% para el LED que indica la estimulacion electrica.

cmc_enviar_senal_estimulo(OA,[1 1 0],Sonido,Luz,.3,.05);
