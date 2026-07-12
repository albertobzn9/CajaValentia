function limite = cmc_limite_duracion_sin_cruce(duracionConfigurada)
%CMC_LIMITE_DURACION_SIN_CRUCE Limita a 60 s los ensayos sin desplazamiento.

if isempty(duracionConfigurada) || duracionConfigurada <= 0
    error('CajaValentia:Duracion', 'La duracion configurada debe ser positiva.');
end

limite = min(duracionConfigurada,60);
end
