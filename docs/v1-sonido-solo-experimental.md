# V1 Con Sonido Solo Experimental

Esta rama parte de `v1.0.0`. La secuencia de ensayos normales sigue siendo
`OA_SecuenciaEnsayos3` sin cambios. Con riesgo mayor que cero, se elige al azar
un ensayo dentro de cada bloque completo de diez; despues de ese ensayo se
ejecuta un control adicional de sonido. Los ensayos normales mantienen su
orden, su logica de mismo lado y el contador visible `EnsayoValido`.

El control usa el canal de audio del lado opuesto al objetivo programado del
ensayo normal anterior, LED rojo y parrilla. No enciende focos de comida ni
entrega pellets. Dura lo configurado en la GUI como duracion maxima del ensayo
de riesgo. Una solicitud de detener interrumpe el control y apaga las salidas.
El cierre de la GUI ordena apagar la parrilla antes de reiniciar la tarjeta;
para terminar una sesion se debe usar el boton de detener, no cerrar la ventana.

La tabla conserva ocho columnas. La fila del control tiene `3` en la columna
`Lado` y `1` en la columna de estimulo. La columna `Ensayo` repite el numero
del ensayo normal tras el que se inserto el control; las demas columnas tienen
los mismos significados que en v1. La ultima columna registra la primera
llegada al lado objetivo o la duracion maxima si no se detecta. El control no
incrementa `EnsayoValido` ni `Ensayo`; por ello el cierre existente sigue
dependiendo del numero de ensayos normales configurado. Si se detiene a mitad
del control, no se agrega una fila de evento completo.

La prueba de programacion y formato se ejecuta sin hardware desde la carpeta
`matlab/`:

```matlab
addpath(fullfile('..','tests','sonido_solo_v1'));
cmc_prueba_sonido_solo_v1
```

Antes de usar con animales, probar en R2011a con la caja vacia y una persona
entrenada. Confirmar con `which` que GUI y funciones proceden de esta copia.
Para una sola insercion, configurar 10 ensayos normales, riesgo mayor que cero,
habituaciones de 0 s y duraciones maximas breves aprobadas por el operador.
Resultado esperado: una fila adicional con columnas 2 y 3 iguales a `3` y `1`,
en alguna posicion posterior a los ensayos normales 1 a 10; audio, LED rojo y
parrilla durante la duracion maxima de riesgo, sin foco de comida ni pellet.
Comprobar que las tres salidas se apaguen al terminar y al pulsar Detener.
No probar con animales hasta verificar estas observaciones.
