function h=crearOBJ

h=digitalio('nidaq','Dev2');
addline(h, 0:7, 0, 'in');

