function dio=OA_ValentiaInicio
dio=digitalio('nidaq','Dev2');
addline(dio, 0:7, 0, 'In');
addline(dio, 0:7, 1, 'Out');
addline(dio, 0:7, 2, 'Out');

escribePto(dio,[24],[0]);
% Arranque seguro: no activar lineas de pellet al abrir la GUI.
escribePto(dio,17:23,zeros(1,7));



