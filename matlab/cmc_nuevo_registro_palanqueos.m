function [estado, eventos] = cmc_nuevo_registro_palanqueos
%CMC_NUEVO_REGISTRO_PALANQUEOS Inicializa el registro crudo de palanqueos.

estado = struct('izq', 0, 'der', 0, 'inicializado', 0);
eventos = struct('tiempo_s', {}, 'fase', {}, 'ensayo', {}, ...
    'tipo_evento', {}, 'lado', {}, 'contador_hardware', {});
