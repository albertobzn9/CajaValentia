function [Resultados,Secuencia] = cmc_simulacion_discriminacion_sonido_solo(Riesgo)
%CMC_SIMULACION_DISCRIMINACION_SONIDO_SOLO Simula tres bloques sin hardware.

if nargin < 1
    Riesgo = 0.3;
end

cmc_setup_paths();
rand('state',2);
[Secuencia,ModoSonidoSolo] = OA_SecuenciaDiscriminacionSonidoSolo(30,3,Riesgo);
assert(ModoSonidoSolo == 1, 'La simulacion DIS requiere Riesgo mayor que 0.');
assert(size(Secuencia,1) == 33, 'Tres bloques deben contener 33 eventos.');

NumRiesgo = round(Riesgo*10);
Resultados = zeros(33,9);
Tiempo = 0;

for Ensayo = 1:33
    Tipo = Secuencia(Ensayo,2);
    if Tipo == 2
        Duracion = 180;
        Desplazamiento = 30; % Cruce simulado, sin terminar el evento.
    else
        Duracion = 20 + round(20*rand(1,1));
        Desplazamiento = Duracion;
    end

    Tiempo = Tiempo + Duracion;
    Resultados(Ensayo,:) = [Ensayo Secuencia(Ensayo,1) (Tipo > 0) ...
        Duracion Tiempo 0 0 Desplazamiento Tipo];
end

assert(Secuencia(1,2) == 0, 'El primer evento debe ser seguro.');
for Bloque = 1:3
    Inicio = (Bloque-1)*11+1;
    Tipos = Secuencia(Inicio:Inicio+10,2);
    assert(sum(Tipos == 0) == 10-NumRiesgo, 'Seguros incorrectos en bloque DIS.');
    assert(sum(Tipos == 1) == NumRiesgo, 'Conflictos incorrectos en bloque DIS.');
    assert(sum(Tipos == 2) == 1, 'Falta o sobra sonido solo en bloque DIS.');
end
for i = 2:33
    if Secuencia(i,2) > 0
        assert(Secuencia(i,1) ~= Secuencia(i-1,1), ...
            'Riesgo o sonido solo aparecio sin cambio de lado.');
    end
end
assert(all(Resultados(Resultados(:,9) == 2,4) == 180), ...
    'Sonido solo DIS debe durar 180 s.');
assert(all(Resultados(Resultados(:,9) == 2,8) < 180), ...
    'El cruce simulado no debe cortar el sonido solo DIS.');

fprintf('OK DIS: 3 bloques, Riesgo %.2f, %d conflicto(s) + 1 sonido solo por bloque.\n', ...
    Riesgo,NumRiesgo);
