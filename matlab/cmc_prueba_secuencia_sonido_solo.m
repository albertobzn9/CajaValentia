function cmc_prueba_secuencia_sonido_solo
%CMC_PRUEBA_SECUENCIA_SONIDO_SOLO Prueba sin tarjeta NI ni audio.

cmc_setup_paths();
cmc_prueba_bloques(0.1, [9 1 1]);
cmc_prueba_bloques(0.3, [7 3 1]);
[Secuencia,Modo] = OA_SecuenciaDiscriminacionSonidoSolo(300,3,0);
assert(Modo == 0, 'Riesgo 0 debe conservar cruces seguros.');
assert(sum(Secuencia(:,2) == 2) == 0, 'Cruces seguros no debe incluir sonido solo.');
disp('OK: secuencias de discriminacion y cruces seguros validadas.');

function cmc_prueba_bloques(Riesgo, Esperado)
[Secuencia,Modo] = OA_SecuenciaDiscriminacionSonidoSolo(300,3,Riesgo);
assert(Modo == 1, 'Riesgo mayor que 0 debe activar sonido solo.');
assert(size(Secuencia,1) == 330, '300 ensayos deben producir 330 eventos.');
assert(Secuencia(1,2) == 0, 'El primer evento debe ser seguro.');

for Bloque = 1:30
    Inicio = (Bloque - 1) * 11 + 1;
    Tipos = Secuencia(Inicio:Inicio + 10,2);
    assert(sum(Tipos == 0) == Esperado(1), 'Numero incorrecto de ensayos seguros.');
    assert(sum(Tipos == 1) == Esperado(2), 'Numero incorrecto de ensayos de conflicto.');
    assert(sum(Tipos == 2) == Esperado(3), 'Debe haber un evento de sonido solo.');

    for i = Inicio:Inicio + 10
        if i > 1 && Secuencia(i,2) > 0
            assert(Secuencia(i,1) ~= Secuencia(i - 1,1), ...
                'Riesgo o sonido solo aparecio sin cambio de lado.');
        end
    end
end
