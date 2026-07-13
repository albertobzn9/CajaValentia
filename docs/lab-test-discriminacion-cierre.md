# Cierre De Discriminacion: Prueba De Laboratorio

Rama: `feature/discriminacion-cierre-habituacion`. Esta prueba cierra
Discriminacion; no iniciar Cruces Peligrosos hasta registrarla como aprobada.

## Antes De Empezar

- Desplegar una copia separada de esta rama. No sobrescribir
  `CajaValentia_R2011a_CrucesSensor`.
- Abrir `Abrir_CajaValentia_CierreHab_Pruebas.bat` del Escritorio y conservar
  su log. El lanzador usa MATLAB R2011a y la copia aislada en `Documents`.
- Usar la caja sin animal para estas validaciones tecnicas.

## Prueba 1: Flujo Corto, Contador Y LED

En `ValentiaE`, usar riesgo `0`, ensayos a realizar `1`, habituacion `15 s`,
duracion maxima segura `30 s` y activar `Aviso LED al finalizar`.

1. Iniciar. Debe verse `Hab. inicial: 00:00 / 00:15` y avanzar hasta `00:15`.
2. Completar un cruce seguro y una palanqueada valida.
3. La sesion debe ir sola a habituacion final, mostrando
   `Hab. final: 00:00 / 00:15`.
4. Al abrir Guardar resultados, confirmar visualmente LED de 100 ms cada 1 s.
5. Guardar como `validacion_cierre_corta.csv`.

## Prueba 2: Limite Real De 60 S

Usar riesgo `0`, ensayos a realizar `1`, habituacion `0 s` y duracion maxima
segura `180 s`. Mantener la mano en el lado de inicio; cuando aparezca la luz
en el lado opuesto, no cruzar ni palanquear.

Esperado: el evento termina cerca de 60 s, cuenta como no-cruce lateral y la
sesion pasa sola al guardado final. Guardar como `validacion_limite_60s.csv`.

## Archivos Que Se Revisan Por SSH

Cada guardado produce, junto al CSV elegido:

- `nombre.csv`: eventos.
- `nombre_palanqueos.csv`: una fila por palanqueada.
- `nombre_resumen.txt`: conteo de eventos, tipos y palanqueos por fase.

Ademas, `matlab/resultados/ultima_sesion_guardada.txt` apunta al ultimo CSV y
resumen. Asi el agente puede localizarlos sin pedir capturas ni mover USB.

## Criterio De Aprobacion

Las dos pruebas deben producir sus tres archivos, el contador debe ser legible,
el LED debe detenerse al cerrar el dialogo y el segundo CSV debe registrar
`latencia_s` cercana a 60 s.
