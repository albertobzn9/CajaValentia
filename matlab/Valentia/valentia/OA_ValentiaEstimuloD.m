function OA_ValentiaEstimuloD(OA,Sonido,Luz,varargin)

%Luz: 0 apagado, 1 continuo, 2 intermitente.
%Sonido: 0 apagado, 1 continuo, 2 intermitente.

% El sonido ya no se controla desde esta funcion. Sus bits se reutilizan
% para el LED que indica la estimulacion electrica.

PausaPulso = .3;
PausaEstabilizacion = .05;
if nargin >= 4 && ~isempty(varargin{1})
    PausaPulso = varargin{1};
    if PausaPulso == 0
        % El aviso LED final controla su propio calendario con un timer.
        PausaEstabilizacion = 0;
    end
end

cmc_enviar_senal_estimulo( ...
    OA,[1 0 0],Sonido,Luz,PausaPulso,PausaEstabilizacion);

