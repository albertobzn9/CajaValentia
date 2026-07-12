function [estado, eventos, nuevosIzq, nuevosDer] = cmc_registrar_palanqueos( ...
    estado, eventos, izq, der, tiempo_s, fase, ensayo, tipoEvento)
%CMC_REGISTRAR_PALANQUEOS Convierte los contadores fisicos en eventos.
% La caja expone cuatro bits por lado; el contador pasa de 15 a 0.

nuevosIzq = 0;
nuevosDer = 0;

% Fuera de un ensayo no existe un numero de ensayo real.
if ~strcmp(fase, 'ensayo')
    ensayo = NaN;
end

if estado.inicializado == 0
    estado = cmc_reiniciar_referencia_palanqueos(estado, izq, der);
    return
end

nuevosIzq = mod(izq - estado.izq, 16);
nuevosDer = mod(der - estado.der, 16);

for n = 1:nuevosIzq
    estado.evento_sesion = estado.evento_sesion + 1;
    estado.contador_izq_sesion = estado.contador_izq_sesion + 1;
    eventos(end + 1) = cmc_evento_palanqueo( ...
        estado.evento_sesion, tiempo_s, fase, ensayo, tipoEvento, 'I', ...
        estado.contador_izq_sesion, mod(estado.izq + n, 16));
end
for n = 1:nuevosDer
    estado.evento_sesion = estado.evento_sesion + 1;
    estado.contador_der_sesion = estado.contador_der_sesion + 1;
    eventos(end + 1) = cmc_evento_palanqueo( ...
        estado.evento_sesion, tiempo_s, fase, ensayo, tipoEvento, 'D', ...
        estado.contador_der_sesion, mod(estado.der + n, 16));
end

estado.izq = izq;
estado.der = der;
