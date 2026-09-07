function cmc_prueba_secuencia_sonido_solo
%CMC_PRUEBA_SECUENCIA_SONIDO_SOLO Prueba sin tarjeta NI ni audio.

cmc_setup_paths();
cmc_prueba_bloques(0.1, [9 1]);
cmc_prueba_bloques(0.3, [7 3]);
[Secuencia,Modo] = OA_SecuenciaDiscriminacionSonidoSolo(300,3,0);
assert(Modo == 0, 'Riesgo 0 debe conservar cruces seguros.');
assert(sum(Secuencia(:,2) == 2) == 0, 'Cruces seguros no debe incluir sonido solo.');
disp('OK: secuencias de discriminacion y cruces seguros validadas.');
end

function cmc_prueba_bloques(Riesgo, Esperado)
[Secuencia,Modo] = OA_SecuenciaDiscriminacionSonidoSolo(300,3,Riesgo);
assert(Modo == 1, 'Riesgo mayor que 0 debe activar sonido solo.');
assert(Secuencia(1,2) == 0, 'El primer evento debe ser seguro.');
assert(cmc_cuenta_ensayos_cruce_programados(Secuencia) == 300, ...
    'La secuencia debe contener 300 ensayos programados de cruce.');
assert(sum(Secuencia(:,2) == 2) == 30, ...
    'Debe existir un sonido solo por cada diez ensayos de cruce.');

TiposCruce = cmc_tipos_cruce_programados(Secuencia);
for Bloque = 1:30
    Inicio = (Bloque - 1) * 10 + 1;
    Tipos = TiposCruce(Inicio:Inicio + 9);
    assert(sum(Tipos == 0) == Esperado(1), 'Numero incorrecto de ensayos seguros.');
    assert(sum(Tipos == 1) == Esperado(2), 'Numero incorrecto de ensayos de conflicto.');
end

for i = 2:size(Secuencia,1)
    if Secuencia(i,2) > 0
        assert(Secuencia(i,1) ~= Secuencia(i - 1,1), ...
            'Riesgo o sonido solo aparecio sin cambio de lado.');
    end
end
end


function tipos = cmc_tipos_cruce_programados(Secuencia)
tipos = [];
for i = 1:size(Secuencia,1)
    mismoLado = i > 1 && Secuencia(i-1,1) == Secuencia(i,1);
    if cmc_es_ensayo_cruce_programado(mismoLado,Secuencia(i,2))
        tipos = [tipos Secuencia(i,2)]; %#ok<AGROW>
    end
end
end
