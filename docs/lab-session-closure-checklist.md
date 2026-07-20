# Cierre De Prueba En Laboratorio

Usar este checklist al terminar una prueba supervisada de `ValentiaE`.
No sustituye el protocolo conductual ni autoriza cambiar parametros durante la
sesion. Su funcion es preservar evidencia tecnica sin guardar identificadores
de animales en Git.

## Durante La Prueba

- No iniciar un segundo programa de la caja.
- El operador frente a la caja conserva el control de `Inicio`, `Detener ahora`
  y del guardado.
- Si ocurre una salida inesperada, un bloqueo o un comportamiento que parezca
  inseguro, usar `Detener ahora`, anotar la observacion y no aplicar cambios
  de codigo durante esa sesion.
- Para Cruces Seguros con riesgo `0`, no debe haber sonido solo, ruido blanco,
  LED marcador ni estimulo electrico.
- El contador visible de `main` cuenta filas de resultados; no usarlo como
  conteo de cruces validos.

## Al Terminar

1. Dejar que termine la habituacion final solo si el protocolo lo requiere.
   Si el programa queda esperando una palanca despues de detectar llegada,
   usar `Detener ahora`; `Detener tras ensayo` no interrumpe ese estado.
2. Guardar desde el dialogo final en la carpeta `resultados` de la copia
   desplegada. Usar un nombre operativo sin identificadores de animal.
3. Completar `DESPLIEGUE_Y_REGISTRO.txt` localmente con tarea, parametros,
   observacion esperada, observacion real y nombres de los archivos creados.
4. Conservar juntos el CSV principal, el CSV de palanqueos y el log del
   lanzador. No moverlos, renombrarlos ni subirlos a Git durante la sesion.
5. Solicitar una inspeccion posterior de solo lectura para confirmar que los
   archivos existen, tienen contenido y se pueden leer.

## Criterio Tecnico De La Prueba Corta

Registrar por separado si se observo cada punto:

- La GUI abre desde la copia aislada de `main`.
- La habituacion inicial transcurre y el reloj visible cambia.
- En Cruces Seguros, la luz segura se comporta como se espera.
- Sensor de llegada, palanca y pellet responden en un evento seguro.
- No aparecen salidas de riesgo cuando el riesgo esta en `0`.
- `Detener ahora` responde de forma comprensible para el operador.
- El cierre, la habituacion final si aplica, el dialogo CSV predeterminado y
  los dos archivos resultantes se completan sin error.

## Marcas De Tiempo

La PC del laboratorio tenia el reloj en 2016 durante el despliegue de esta
copia. Mientras no se corrija, sus fechas no son una referencia confiable de
la sesion. Conservar la hora real por separado en el registro local y no
modificar el reloj durante una prueba en curso.
