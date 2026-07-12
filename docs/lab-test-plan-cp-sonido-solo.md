# Prueba CP: Sonido Solo

Rama: `feature/cp-time-aware-sound-only`. Ejecutar primero con MATLAB R2011a
y la copia desplegada en `C:\Users\Alberto\Desktop\CajaValentia`, abierta con
`Abrir_CajaValentia_R2011a.bat` como usuario normal.

## Pruebas Cortas

1. Abrir `Abrir_CajaValentia_R2011a.bat` con doble clic: no debe aparecer UAC
   ni pedir administrador; MATLAB debe abrir bajo el usuario Alberto.
2. Abrir `ValentiaE2`: no debe caer pellet ni prender estimulos.
3. Confirmar valores por defecto: riesgo `1`, maximo mismo lado `1`, pellets
   riesgo `1`, frecuencia riesgo `15000`, duracion manual correcta.
4. Con una prueba corta y operador frente a la caja: confirmar que cada lado
   normal entrega un pellet por una presion valida.
   Si se cruza sin palanquear, confirmar que el evento se cierra a
   `duracion maxima + 10 s` y no entrega pellet.
5. Hacer sonar un control: el lado de audio debe corresponder al lado objetivo
   opuesto al lado de origen de `Secuencia`.
6. Probar `Terminar` durante ITI y durante un ensayo: luces, parrilla y audio
   se apagan; despues ocurre habituacion final y se ofrece guardar.
   Probar tambien `Detener tras ensayo`: en ITI no inicia otro ensayo; durante
   un ensayo espera su cierre normal y luego inicia habituacion final.
7. Guardar: deben salir `nombre.csv` y `nombre_palanqueos.csv`. El segundo
   debe registrar fases `habituacion_inicial`, `sin_luz`, `ensayo`,
   `sonido_solo` y `habituacion_final` cuando se hayan producido.

## Sesion Completa

- Habituacion inicial: 5 min.
- Conducta: 30 min desde que se cierra el mensaje de modo CP.
- Controles sonido solo: cerca de min 9, 18 y 27; duran lo configurado en
  `Duracion maxima del ensayo` y no ofrecen luz de comida ni pellet.
- Habituacion final: 5 min, iniciada cuando no debe empezar otro ensayo antes
  del limite conductual. Un evento ya iniciado puede terminar despues de min 30.

No usar con animales para datos experimentales hasta completar estas pruebas y
archivar ambos CSV de una sesion de verificacion.
