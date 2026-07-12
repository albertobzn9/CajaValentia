function cmc_detener_aviso_led_final(aviso, OA)
%CMC_DETENER_AVISO_LED_FINAL Detiene el timer y deja el LED apagado.

if ~isempty(aviso) && ishandle(aviso)
    try
        stop(aviso);
    catch
    end
    delete(aviso);
end

if nargin >= 2 && ~isempty(OA)
    try
        OA_ValentiaEstimuloD(OA, 0, 0, 0);
    catch
        % El guardado no debe fallar solo porque falle el aviso opcional.
    end
end
