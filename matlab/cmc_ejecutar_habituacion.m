function [estado, eventos, contadorIzq, contadorDer, detenido] = cmc_ejecutar_habituacion( ...
    handles, duracion, estado, eventos, relojSesion, fase, contadorIzq, contadorDer)
%CMC_EJECUTAR_HABITUACION Ejecuta una habituacion y registra palanqueos.

[izq, der] = OA_ValentiaRevisaPalanca(handles.OA);
estado = cmc_reiniciar_referencia_palanqueos(estado, izq, der);
reloj = tic;
detenido = false;
cmc_actualizar_reloj_fase(handles.edit9, [strrep(fase, '_', ' ') ' (s)'], 0, duracion);

while toc(reloj) < duracion
    [estado, eventos, nuevosIzq, nuevosDer] = cmc_observar_palanqueos( ...
        handles.OA, estado, eventos, toc(relojSesion), fase, 0, 'ninguno');
    contadorIzq = contadorIzq + nuevosIzq;
    contadorDer = contadorDer + nuevosDer;
    set(handles.edit20, 'String', num2str(contadorIzq));
    set(handles.edit21, 'String', num2str(contadorDer));
    cmc_actualizar_reloj_fase(handles.edit9, [strrep(fase, '_', ' ') ' (s)'], ...
        toc(reloj), duracion);
    control = load('ControlTarea','CT_Ejecuta');
    if control.CT_Ejecuta == 0
        detenido = true;
        return
    end
    pause(min(.3, max(0, duracion-toc(reloj))));
end
