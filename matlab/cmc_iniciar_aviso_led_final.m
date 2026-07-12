function aviso = cmc_iniciar_aviso_led_final(OA)
%CMC_INICIAR_AVISO_LED_FINAL Parpadea el LED marcador mientras se guarda.
% El timer no participa en la tarea: solo sirve como aviso al experimentador.

aviso = [];
if isempty(OA)
    return
end

estado = struct('OA', OA, 'inicio', tic, 'encendido', false);
try
    aviso = timer('ExecutionMode', 'fixedSpacing', 'Period', 0.05, ...
        'BusyMode', 'drop', 'TimerFcn', @cmc_actualizar_aviso_led);
    set(aviso, 'UserData', estado);
    cmc_actualizar_aviso_led(aviso, []);
    start(aviso);
catch ME
    if ~isempty(aviso) && ishandle(aviso)
        delete(aviso);
    end
    aviso = [];
    warning('CajaValentia:AvisoLed', ...
        'No se pudo iniciar el aviso LED: %s', ME.message);
end

function cmc_actualizar_aviso_led(objeto, ~)
estado = get(objeto, 'UserData');
debeEncender = cmc_led_aviso_activo(toc(estado.inicio));
if debeEncender == estado.encendido
    return
end

try
    % Cuarto argumento 0: el pulso lo controla el timer, no la pausa legacy.
    OA_ValentiaEstimuloD(estado.OA, 2 * debeEncender, 0, 0);
    estado.encendido = debeEncender;
    set(objeto, 'UserData', estado);
catch ME
    warning('CajaValentia:AvisoLed', 'Fallo al actualizar LED: %s', ME.message);
end
