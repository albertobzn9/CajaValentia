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
- El 16-jul-2026 se ejecuto `cmc_prueba_sin_hardware_completa` con MATLAB
  R2011a sobre la copia aislada de `origin/main` en la PC del laboratorio. Se
  uso modo sin escritorio y sin ventanas de figuras; la suite aprobo. Esta
  evidencia confirma solo logica y compatibilidad basica de MATLAB, no GUI ni
  salidas/entradas fisicas.
- En una prueba supervisada de `ValentiaE` el 16-jul-2026 se observo que
  **Ensayos terminados** incrementaba tanto cruces como no-cruces. Esta
  observacion motivo una correccion separada que usa `CruceValido` para el
  contador y el final automatico. Requiere prueba sin hardware y prueba fisica
  corta antes de llevarla a `main`.
  La investigacion historica identifica dos antecedentes: V1 usaba
  `EnsayoValido` para mostrar llegadas en cambios de lado, pero no usaba ese
  valor para terminar la sesion; V2.4 usaba `EnsayosCruce` tanto para mostrar
  como para terminar, pero tambien contaba ciertos no-cruces por una regla
  deliberada para ratas temerosas. La correccion futura no debe copiar V2.4
  completa. `main` ya contiene `cmc_es_cruce_valido`, la base mas pequena para
  contar solamente cruces validos sin regresar a 10 columnas ni a las otras
  modificaciones experimentales.
- Hubo pruebas R2011a de Discriminacion el 12-jul-2026, pero varias verificaron
  reglas que ya no pertenecen a `main`. Se conservan como historia en la
  [bitacora](bitacora-lab-2026-07-12-valentiae.md), no como certificacion de
  los conteos actuales.

## Pendiente Antes De Uso Critico

- ValentiaE: prueba corta de reloj de habituacion, LED final opcional, guardado
  de CSV principal mas CSV de palanqueos y respuesta de **Detener ahora**.
- ValentiaE2/CP: prueba fisica completa, incluidos ITI, eventos de sonido solo,
  guardado manual y el caso cruzar sin palanquear.
- Moldeamiento y Luz-Comida: comprobar el boton de detener del lado derecho
  antes de una sesion real.
- MATLAB moderno: DAQ/audio no estan validados y no sustituyen R2011a.
