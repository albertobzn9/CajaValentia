# Estado De Validacion

## Discriminacion: Validada En R2011a

- Suite sin hardware en R2026a: riesgo `0`, `0.1`, `0.15`, `0.2`, `0.3`,
  `0.6`, resultados, reloj, LED y simulaciones CP.
- Audio estereo, diagnostico de sonido solo, arranque sin pellet, guardado CSV,
  contador de cruces/no-cruces, sonido solo y cierre automatico: probados con
  la caja en R2011a el 12-jul-2026.
- La evidencia y los dos pendientes menores de Discriminacion estan en la
  [bitacora de laboratorio](bitacora-lab-2026-07-12-valentiae.md).

## Pendiente Para Cerrar Discriminacion

- Discriminacion: validar en la caja el contador dedicado de habituacion, el
  aviso LED final de 100 ms cada segundo, el limite real de 60 s y el cierre
  automatico. El plan y los archivos esperados estan en
  [la prueba de cierre](lab-test-discriminacion-cierre.md).
- Discriminacion: confirmar si el lanzador diario puede ejecutarse sin
  administrador. Hasta esa prueba, el flujo validado sigue siendo elevado.
- CP (`ValentiaE2`): prueba fisica completa antes de fusionar
  `feature/cp-time-aware-sound-only`. Ver el checklist exacto en
  [`architecture/06_cambios_reutilizables_discriminacion_a_cp.md`](architecture/06_cambios_reutilizables_discriminacion_a_cp.md).
- MATLAB moderno: la migracion de DAQ/audio no esta validada con la caja y no
  sustituye R2011a.
