function plan = cmc_planificador_cp_sonido_solo(tiempoConducta, duracionNormal, proximoSonido)
%CMC_PLANIFICADOR_CP_SONIDO_SOLO Agenda CP con ITI aleatorio y limite temporal.
% Los sonidos se buscan cerca de 9, 18 y 27 min. Cerca del final se reduce
% solo el ultimo ITI necesario para que el sonido pendiente inicie antes de
% cerrar los 30 min conductuales. Un ensayo ya iniciado puede terminar despues.

limiteConducta = 30 * 60;
objetivos = [9 18 27] * 60;
margenInicio = 10;
ultimoInicioPermitido = limiteConducta - margenInicio;

plan = struct('limite_conducta_s', limiteConducta, ...
    'objetivos_sonido_s', objetivos, 'margen_inicio_s', margenInicio, ...
    'ejecutar_sonido', false, 'finalizar_sin_nuevo_ensayo', false, ...
    'max_iti_s', max(0, ultimoInicioPermitido - tiempoConducta));

if proximoSonido > numel(objetivos)
    plan.finalizar_sin_nuevo_ensayo = tiempoConducta >= ultimoInicioPermitido;
    return
end

objetivo = objetivos(proximoSonido);
plan.objetivo_sonido_s = objetivo;

% No iniciar otro CP normal si podria empujar el sonido pendiente mas alla
% del limite. En ese caso se adelanta el sonido, pero nunca se corta un ensayo.
plan.ejecutar_sonido = tiempoConducta >= objetivo || ...
    tiempoConducta + duracionNormal >= ultimoInicioPermitido;
plan.max_iti_s = max(0, ultimoInicioPermitido - duracionNormal - tiempoConducta);
