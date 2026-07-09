function [Secuencia, ModoSonidoSolo] = OA_SecuenciaDiscriminacionSonidoSolo(NumEnsayos, NumRepLado, Riesgo)
%OA_SECUENCIADISCRIMINACIONSONIDOSOLO Genera DIS con sonido solo.
%
% Tipo de evento: 0 seguro, 1 conflicto con comida, 2 sonido/parrilla sin comida.
% Los tipos 1 y 2 siempre fuerzan un cambio de lado. Riesgo 0 conserva la
% secuencia historica de cruces seguros y no agrega eventos de sonido solo.

if isempty(Riesgo) || Riesgo < 0 || Riesgo >= 1
    error('CMC:Riesgo', 'Riesgo debe estar entre 0 y menor que 1; por ejemplo 0.1 o 0.3.');
end

if isempty(NumRepLado) || NumRepLado < 1
    error('CMC:Repeticiones', 'El maximo de repeticiones por lado debe ser al menos 1.');
end

if Riesgo == 0
    Secuencia = [OA_Secuencia(1000, NumRepLado) zeros(1000,1)];
    ModoSonidoSolo = 0;
    return
end

if isempty(NumEnsayos) || NumEnsayos <= 0 || mod(NumEnsayos,10) ~= 0
    error('CMC:NumEnsayos', 'En discriminacion, el numero de ensayos debe ser positivo y multiplo de 10.');
end

NumRiesgo = round(Riesgo * 10);
if NumRiesgo >= 10
    error('CMC:Riesgo', 'Debe quedar al menos un ensayo seguro por bloque.');
end

NumBloques = NumEnsayos / 10;
TotalEventos = NumEnsayos + NumBloques;
Secuencia = zeros(TotalEventos,2);
ModoSonidoSolo = 1;
LadoAnterior = round(rand(1,1));
Repeticiones = 0;

for Bloque = 1:NumBloques
    Inicio = (Bloque - 1) * 11 + 1;
    Tipos = [zeros(10 - NumRiesgo,1); ones(NumRiesgo,1); 2];
    Tipos = Tipos(randperm(11));

    % El primer evento de toda sesion debe ser seguro.
    if Bloque == 1
        iSeguro = find(Tipos == 0);
        Temporal = Tipos(1);
        Tipos(1) = 0;
        Tipos(iSeguro(1)) = Temporal;
    end

    for i = 1:11
        TipoEvento = Tipos(i);
        if Inicio == 1 && i == 1
            Lado = LadoAnterior;
            Repeticiones = 1;
        elseif TipoEvento > 0
            % Conflicto y sonido solo solo existen cuando hay cambio de lado.
            Lado = not(LadoAnterior);
            Repeticiones = 1;
        elseif Repeticiones >= NumRepLado || rand(1,1) >= 0.5
            Lado = not(LadoAnterior);
            Repeticiones = 1;
        else
            Lado = LadoAnterior;
            Repeticiones = Repeticiones + 1;
        end

        Secuencia(Inicio + i - 1,:) = [Lado TipoEvento];
        LadoAnterior = Lado;
    end
end
