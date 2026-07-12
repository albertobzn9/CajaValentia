function evento = cmc_evento_palanqueo(tiempo_s, fase, ensayo, tipoEvento, lado, contador)
%CMC_EVENTO_PALANQUEO Crea una fila autocontenida para el registro de conducta.

evento = struct('tiempo_s', tiempo_s, 'fase', fase, 'ensayo', ensayo, ...
    'tipo_evento', tipoEvento, 'lado', lado, 'contador_hardware', contador);
