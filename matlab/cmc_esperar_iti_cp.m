function [contadorIzq, contadorDer, detenido, estado, eventos] = ...
    cmc_esperar_iti_cp(handles, duracion, contadorIzq, contadorDer, estado, eventos, relojSesion)
%CMC_ESPERAR_ITI_CP Espera un ITI CP sin bloquear el boton Terminar.

detenido = false;
if duracion <= 0
    return
end

[izqAnterior, derAnterior] = OA_ValentiaRevisaPalanca(handles.OA);
if nargin >= 7
    estado = cmc_reiniciar_referencia_palanqueos(estado, izqAnterior, derAnterior);
else
    estado = [];
    eventos = [];
end
reloj = tic;
while toc(reloj) < duracion
    if nargin >= 7
        [estado, eventos, nuevosIzq, nuevosDer, izq, der] = cmc_observar_palanqueos( ...
            handles.OA, estado, eventos, toc(relojSesion), 'sin_luz', 0, 'ninguno');
        contadorIzq = contadorIzq + nuevosIzq;
        contadorDer = contadorDer + nuevosDer;
    else
        [izq, der] = OA_ValentiaRevisaPalanca(handles.OA);
        if izq ~= izqAnterior
            contadorIzq = contadorIzq + 1;
        end
        if der ~= derAnterior
            contadorDer = contadorDer + 1;
        end
    end
    izqAnterior = izq;
    derAnterior = der;

    cmc_actualizar_reloj_fase(handles.edit9, 'Sin luz / ITI (s)', toc(reloj), duracion);
    drawnow;
    control = load('ControlTarea','CT_Ejecuta','CT_FinalizarTrasEnsayo');
    if control.CT_Ejecuta == 0 || control.CT_FinalizarTrasEnsayo == 1
        detenido = true;
        return
    end
    pause(min(.1, max(0, duracion-toc(reloj))));
end
