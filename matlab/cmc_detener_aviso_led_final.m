function cmc_detener_aviso_led_final(aviso, OA)
%CMC_DETENER_AVISO_LED_FINAL Detiene avisos activos y deja el LED apagado.

avisos = timerfindall('Tag', 'CajaValentiaAvisoLedFinal');
if ~isempty(aviso) && ishandle(aviso)
    avisos = [avisos(:); aviso];
end

for i = 1:numel(avisos)
    if ishandle(avisos(i))
        try
            stop(avisos(i));
        catch
        end
        try
            delete(avisos(i));
        catch
        end
    end
end

if nargin >= 2 && ~isempty(OA)
    try
        OA_ValentiaEstimuloD(OA, 0, 0, 0);
    catch
        % El guardado no debe fallar solo porque falle el aviso opcional.
    end
end
