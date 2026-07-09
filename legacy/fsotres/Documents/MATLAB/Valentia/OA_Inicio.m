function dio=OA_SotresInicio
dio=digitalio('nidaq','Dev2');
addline(dio, 0:7, 0, 'In');
addline(dio, 0:7, 1, 'Out');
addline(dio, 0:7, 2, 'Out');



putvalue(dio.Line([20],[1]));
putvalue(dio.Line(16),[1])
putvalue(dio.Line(16),[0])

pause(5)


putvalue(dio.Line([20 21],[0 1]));
putvalue(dio.Line(16),[1])
putvalue(dio.Line(16),[0])

