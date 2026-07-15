# Estado De Validacion

## Fuente Actual

`main` fue restaurado a la base estable mas reloj de habituacion y aviso LED.
La referencia operativa es
[Comportamiento actual y limitaciones conocidas](current-runtime-behavior-and-known-limitations.md).
No confundir esta base con la rama experimental que generaba un CSV principal
de 10 columnas.

## Evidencia Disponible

- La suite sin hardware se ejecuto antes de integrar la restauracion. Valida
  secuencias y ayudas puramente de software; no valida NI, sensores, palancas
  ni audio real.
- Hubo pruebas R2011a de Discriminacion el 12-jul-2026, pero varias verificaron
  reglas que ya no pertenecen a `main`. Se conservan como historia en la
  [bitacora](bitacora-lab-2026-07-12-valentiae.md), no como certificacion de
  los conteos actuales.

## Pendiente Antes De Uso Critico

- ValentiaE: prueba corta de reloj de habituacion, LED final opcional, guardado
  `.mat` mas CSV de palanqueos y respuesta de **Detener ahora**.
- ValentiaE2/CP: prueba fisica completa, incluidos ITI, eventos de sonido solo,
  guardado manual y el caso cruzar sin palanquear.
- Moldeamiento y Luz-Comida: comprobar el boton de detener del lado derecho
  antes de una sesion real.
- MATLAB moderno: DAQ/audio no estan validados y no sustituyen R2011a.
