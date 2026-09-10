function cmc_prueba_foco_objetivo
%CMC_PRUEBA_FOCO_OBJETIVO Verifica exclusion sin acceder a la tarjeta NI.

for TipoEvento = [0 1]
    for ActivarLuz = [0 1]
        cmc_verifica_caso('I',TipoEvento,ActivarLuz);
        cmc_verifica_caso('D',TipoEvento,ActivarLuz);
    end
end

cmc_verifica_error_tipo_dos;
disp('OK: exclusion de focos de comida validada sin hardware.');
end


function cmc_verifica_caso(LadoObjetivo,TipoEvento,ActivarLuz)
Ordenes = cmc_plan_foco_objetivo(LadoObjetivo,TipoEvento,ActivarLuz);
assert(length(Ordenes) == 2, 'Cada plan debe contener dos ordenes.');
assert(~strcmp(Ordenes(1).Lado,LadoObjetivo), ...
    'La primera orden debe limpiar el lado contrario.');
assert(Ordenes(1).Luz == 0, 'El foco contrario debe quedar apagado.');
assert(strcmp(Ordenes(2).Lado,LadoObjetivo), ...
    'La segunda orden debe fijar el lado objetivo.');
assert(Ordenes(2).Luz == ActivarLuz, ...
    'El foco objetivo no coincide con la configuracion.');

Estado = struct('I',1,'D',1);
for i = 1:length(Ordenes)
    Estado.(Ordenes(i).Lado) = Ordenes(i).Luz;
end
assert(Estado.I + Estado.D <= 1, ...
    'El plan termino con ambos focos de comida encendidos.');
if ActivarLuz == 1
    assert(Estado.(LadoObjetivo) == 1, 'El foco objetivo debe quedar encendido.');
else
    assert(Estado.I == 0 && Estado.D == 0, ...
        'Ambos focos deben quedar apagados cuando ActivarLuz es cero.');
end

Marcadores = [Ordenes.Sonido];
if TipoEvento == 1
    assert(any(Marcadores == 2), 'El ensayo de riesgo debe conservar el marcador.');
else
    assert(all(Marcadores == 0), 'El ensayo seguro no debe activar el marcador.');
end
end


function cmc_verifica_error_tipo_dos
Fallo = false;
try
    cmc_plan_foco_objetivo('I',2,1);
catch ME
    Fallo = strcmp(ME.identifier,'CMC:TipoEventoFoco');
end
assert(Fallo, 'TipoEvento 2 debe permanecer fuera del control de comida.');
end
