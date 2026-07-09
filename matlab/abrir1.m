function abrir1
%ABRIR1 Menu depurado para operar la caja CMC desde esta carpeta.
% Ejecutar desde MATLAB R2011a con:
%   abrir1

baseDir = cmc_setup_paths();
cd(baseDir);

Resp = menu('Caja CMC - Portable Core + Sound-Only Controls', ...
    'Entrena - moldeamiento / palanqueo', ...
    'EntrenaE - luz-comida', ...
    'ValentiaE - cruces seguros / discriminacion / prueba', ...
    'ValentiaE2 - cruces peligrosos', ...
    'Condicionamiento aleatorio', ...
    'Salir');

if Resp == 1
    OA_ValentiaEntrenaPalancasCP;
elseif Resp == 2
    OA_ValentiaEntrenaPalancasCPE;
elseif Resp == 3
    OA_ValentiaCuatroE;
elseif Resp == 4
    OA_ValentiaCuatroE2;
elseif Resp == 5
    OA_Condiciona_Aleatorio;
else
    disp('Menu cerrado.');
end
