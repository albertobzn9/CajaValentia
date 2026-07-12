function zona = cmc_clasifica_zona_posicion(lugar)
%CMC_CLASIFICA_ZONA_POSICION Clasifica una lectura en I, C, D o ambigua.
% Calibrado el 11-jul-2016 con la caja del laboratorio. Los sensores 4 y 9
% quedan activos sin rata/mano y por eso no se usan para decidir la zona.

if numel(lugar) ~= 18
    error('CajaValentia:Posicion', 'Se esperaban 18 sensores de posicion.');
end

izquierda = any(lugar(1:3));
centro = any(lugar(10:12));
derecha = any(lugar(17:18));

if izquierda && ~centro && ~derecha
    zona = 'I';
elseif centro && ~izquierda && ~derecha
    zona = 'C';
elseif derecha && ~izquierda && ~centro
    zona = 'D';
else
    zona = 'ambigua';
end
