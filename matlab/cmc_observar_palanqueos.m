function [estado, eventos, nuevosIzq, nuevosDer, izq, der] = cmc_observar_palanqueos( ...
    OA, estado, eventos, tiempo_s, fase, ensayo, tipoEvento)
%CMC_OBSERVAR_PALANQUEOS Lee la caja y actualiza el registro de eventos.

[izq, der] = OA_ValentiaRevisaPalanca(OA);
[estado, eventos, nuevosIzq, nuevosDer] = cmc_registrar_palanqueos( ...
    estado, eventos, izq, der, tiempo_s, fase, ensayo, tipoEvento);
