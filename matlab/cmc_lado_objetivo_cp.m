function ladoObjetivo = cmc_lado_objetivo_cp(ladoOrigen)
%CMC_LADO_OBJETIVO_CP Convierte el lado de origen de Secuencia al objetivo.
% En CP, 1 es izquierda y 0 es derecha. El estimulo se presenta al otro lado.

if ~(isscalar(ladoOrigen) && (ladoOrigen == 0 || ladoOrigen == 1))
    error('CajaValentia:LadoCP', 'El lado de origen debe ser 0 o 1.');
end
ladoObjetivo = 1 - ladoOrigen;
