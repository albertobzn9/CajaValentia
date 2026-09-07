function [Secuencia, ModoSonidoSolo] = OA_SecuenciaDiscriminacionSonidoSolo(NumEnsayos, NumRepLado, Riesgo, ActivarSonidoSolo)
%OA_SECUENCIADISCRIMINACIONSONIDOSOLO Genera DIS con sonido solo.
%
% Tipo de evento: 0 seguro, 1 conflicto con comida, 2 sonido/parrilla sin comida.
% Con sonido activo, cada bloque contiene diez ensayos con comida que exigen
% cambiar de lado. Las repeticiones son seguras y no consumen ese conteo.

if nargin < 4
    ActivarSonidoSolo = 1;
end

if isempty(Riesgo) || Riesgo < 0 || Riesgo >= 1
    error('CMC:Riesgo', 'Riesgo debe estar entre 0 y menor que 1; por ejemplo 0.1 o 0.3.');
end

if isempty(NumRepLado) || NumRepLado < 1 || mod(NumRepLado,1) ~= 0
    error('CMC:Repeticiones', 'El maximo de repeticiones por lado debe ser un entero de al menos 1.');
end

if Riesgo == 0
    Secuencia = [OA_Secuencia(1000, NumRepLado) zeros(1000,1)];
    ModoSonidoSolo = 0;
    return
end

if ActivarSonidoSolo == 0
    Secuencia = OA_SecuenciaEnsayos3(NumRepLado, Riesgo);
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
MaxFilas = NumEnsayos * NumRepLado + NumBloques;
Secuencia = zeros(MaxFilas,2);
Indice = 0;
LadoAnterior = round(rand(1,1));
PrimerEvento = 1;

for Bloque = 1:NumBloques
    TiposCruce = zeros(1,10);
    CandidatosRiesgo = 1:10;
    if Bloque == 1
        CandidatosRiesgo = 2:10;
    end
    if NumRiesgo > 0
        OrdenRiesgo = randperm(length(CandidatosRiesgo));
        Elegidos = CandidatosRiesgo(OrdenRiesgo(1:NumRiesgo));
        TiposCruce(Elegidos) = 1;
    end

    if Bloque == 1 && Bloque == NumBloques
        PosicionesSonido = 1:9;
    elseif Bloque == 1
        PosicionesSonido = 1:10;
    elseif Bloque == NumBloques
        PosicionesSonido = 0:9;
    else
        PosicionesSonido = 0:10;
    end
    OrdenSonido = randperm(length(PosicionesSonido));
    PosicionSonido = PosicionesSonido(OrdenSonido(1));

    for Cambio = 1:10
        if PosicionSonido == Cambio - 1
            LadoAnterior = not(LadoAnterior);
            Indice = Indice + 1;
            Secuencia(Indice,:) = [LadoAnterior 2];
        end

        if PrimerEvento == 1
            Indice = Indice + 1;
            Secuencia(Indice,:) = [LadoAnterior TiposCruce(Cambio)];
            PrimerEvento = 0;
        else
            LadoAnterior = not(LadoAnterior);
            Indice = Indice + 1;
            Secuencia(Indice,:) = [LadoAnterior TiposCruce(Cambio)];
        end

        if ~(Bloque == NumBloques && Cambio == 10)
            LongitudCorrida = cmc_longitud_corrida_legacy(NumRepLado);
            for Repeticion = 2:LongitudCorrida
                Indice = Indice + 1;
                Secuencia(Indice,:) = [LadoAnterior 0];
            end
        end
    end

    if PosicionSonido == 10
        LadoAnterior = not(LadoAnterior);
        Indice = Indice + 1;
        Secuencia(Indice,:) = [LadoAnterior 2];
    end
end

Secuencia = Secuencia(1:Indice,:);
ModoSonidoSolo = 1;
end


function longitud = cmc_longitud_corrida_legacy(NumRepLado)
% Replica la distribucion de longitudes de OA_Secuencia.m.
while 1
    valor = randn(1,1);
    if valor >= 0
        valor = -valor;
    end
    longitud = NumRepLado + ceil(valor * NumRepLado);
    if longitud > 0 && longitud <= NumRepLado
        return
    end
end
end
