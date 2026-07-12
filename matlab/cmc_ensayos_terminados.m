function cantidad = cmc_ensayos_terminados(Resultados)
%CMC_ENSAYOS_TERMINADOS Cuenta solo eventos que dejaron una fila de resultado.
% Incluye no-cruces (-2) y sonido solo completo; excluye un paro a mitad de
% ensayo porque ese caso no debe fabricar una fila.

cantidad = size(Resultados, 1);
