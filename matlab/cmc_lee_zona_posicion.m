function [zona, lecturas] = cmc_lee_zona_posicion(OA)
%CMC_LEE_ZONA_POSICION Confirma la zona actual con tres lecturas breves.
% Solo I o D son posiciones laterales confirmadas. Centro o desacuerdo se
% devuelven como no confirmados para evitar contar un falso cruce.

numeroLecturas = 3;
lecturas = cell(numeroLecturas, 1);
for i = 1:numeroLecturas
    lecturas{i} = cmc_clasifica_zona_posicion(cmc_lee_posicion_cruda(OA));
end

if sum(strcmp(lecturas, 'I')) >= 2
    zona = 'I';
elseif sum(strcmp(lecturas, 'D')) >= 2
    zona = 'D';
elseif sum(strcmp(lecturas, 'C')) >= 2
    zona = 'C';
else
    zona = 'ambigua';
end
