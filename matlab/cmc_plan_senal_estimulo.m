function [Tramas,Pausas] = cmc_plan_senal_estimulo(ControlActivo,Sonido,Luz,PausaPulso,PausaEstabilizacion)
%CMC_PLAN_SENAL_ESTIMULO Construye el pulso para un registro de estimulos.

if nargin < 4
    PausaPulso = .3;
end
if nargin < 5
    PausaEstabilizacion = .05;
end

if length(ControlActivo) ~= 3 || any(ControlActivo ~= 0 & ControlActivo ~= 1)
    error('CMC:ControlEstimulo', 'ControlActivo debe contener tres bits.');
end
if isempty(Sonido) || ~any(Sonido == [0 1 2])
    error('CMC:SonidoEstimulo', 'Sonido debe ser 0, 1 o 2.');
end
if isempty(Luz) || ~any(Luz == [0 1 2])
    error('CMC:LuzEstimulo', 'Luz debe ser 0, 1 o 2.');
end
if PausaPulso < 0 || PausaEstabilizacion < 0
    error('CMC:PausaEstimulo', 'Las pausas no pueden ser negativas.');
end

Datos = zeros(1,4);
if Sonido ~= 0
    Datos(1:2) = [1 1];
end
if Luz == 1
    Datos(3:4) = [1 0];
elseif Luz == 2
    Datos(3:4) = [0 1];
end

ControlInactivo = [0 0 0];
Tramas = [ControlInactivo Datos; ControlActivo Datos; ControlInactivo Datos];
Pausas = [PausaEstabilizacion PausaPulso PausaEstabilizacion];
end
