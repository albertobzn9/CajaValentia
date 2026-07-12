function cmc_prueba_inicio_seguro
%CMC_PRUEBA_INICIO_SEGURO Comprueba que el arranque no pulse pellet.

ruta = fullfile(fileparts(mfilename('fullpath')), '..', 'matlab', ...
    'Valentia', 'OA_ValentiaInicio.m');
codigo = fileread(ruta);
assert(~isempty(strfind(codigo, 'escribePto(dio,17:23,zeros(1,7));')));
assert(isempty(strfind(codigo, 'Datos=[1 0 0 0]')));
disp('OK: OA_ValentiaInicio deja salidas de recompensa apagadas.');
