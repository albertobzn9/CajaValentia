function Armed = cmc_modern_output_state(Action)
%CMC_MODERN_OUTPUT_STATE Estado de seguridad compartido por la sesion MATLAB.

persistent OutputsArmed
if isempty(OutputsArmed)
    OutputsArmed = false;
end

if nargin < 1
    Action = 'isarmed';
end

switch lower(Action)
    case 'arm'
        OutputsArmed = true;
    case 'disarm'
        OutputsArmed = false;
    case 'isarmed'
    otherwise
        error('CMC:OutputStateAction','Accion de seguridad no reconocida: %s.',Action);
end

Armed = OutputsArmed;
