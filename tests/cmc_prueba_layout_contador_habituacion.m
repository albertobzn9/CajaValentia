function cmc_prueba_layout_contador_habituacion
%CMC_PRUEBA_LAYOUT_CONTADOR_HABITUACION Evita choques visuales en GUIDE.

pos = cmc_posiciones_gui_experimental;
reloj = [152.6 17.15 16.4 2.69];
inicio = [152.4 21.0 20.2 2.46];
detener = [153 13.31 20.2 2.46];

assert(~cmc_se_traslapan_layout(pos.contadorHabituacion, reloj));
assert(~cmc_se_traslapan_layout(pos.contadorHabituacion, inicio));
assert(~cmc_se_traslapan_layout(pos.contadorHabituacion, detener));
assert(~cmc_se_traslapan_layout(pos.relojEtiqueta, inicio));
disp('OK: contador de habituacion no se sobrepone a controles activos.');


function seTraslapan = cmc_se_traslapan_layout(a, b)
seTraslapan = a(1) < b(1) + b(3) && b(1) < a(1) + a(3) && ...
    a(2) < b(2) + b(4) && b(2) < a(2) + a(4);
