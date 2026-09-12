function cmc_prueba_sonido_solo_v1
%CMC_PRUEBA_SONIDO_SOLO_V1 Comprueba programacion y fila sin hardware.

sinRiesgo = cmc_posiciones_sonido_solo_v1(30,0);
assert(~any(sinRiesgo));
for repeticion = 1:100
    posiciones = cmc_posiciones_sonido_solo_v1(30,0.3);
    assert(length(posiciones) == 30);
    assert(sum(posiciones) == 3);
    assert(sum(posiciones(1:10)) == 1);
    assert(sum(posiciones(11:20)) == 1);
    assert(sum(posiciones(21:30)) == 1);
end

posiciones = cmc_posiciones_sonido_solo_v1(25,0.3);
assert(sum(posiciones) == 2);
assert(~any(posiciones(21:25)));

fila = cmc_fila_sonido_solo_v1(10,180,250,4,7,6.5);
assert(isequal(fila,[10 3 1 180 250 4 7 6.5]));
disp('OK: sonido solo v1 programado y registrado sin hardware.');
end
