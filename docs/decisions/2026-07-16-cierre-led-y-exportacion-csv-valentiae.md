# Cierre LED Y Exportacion CSV En ValentiaE

## Decision

El aviso LED final se apaga de forma explicita al guardar, cancelar con Escape,
cerrar la GUI o iniciar una sesion nueva. Los timers del aviso usan una etiqueta
propia y se eliminan antes de encender un aviso nuevo.

El guardado de `ValentiaE` exporta un CSV principal de nueve columnas y un CSV
de palanqueos. El dialogo propone `resultados.csv` y muestra CSV por defecto.

## Alcance Limitado

- No cambia luces, sonidos, recompensa, sensores ni tarjeta NI durante la
  tarea.
- No cambia el formato interno de `Resultados`; el CSV lo exporta tal como las
  nueve columnas actuales.
- No modifica el guardado de Cruces Peligrosos ni de los otros programas.

## Validacion Requerida

1. Ejecutar la suite sin hardware, incluida la exportacion de CSV y limpieza
   de timers LED.
2. En la prueba fisica, abrir el popup con aviso LED, guardar una vez y
   cancelar una vez con Escape en una sesion separada.
3. Confirmar que el LED queda apagado, una nueva sesion conserva las luces
   normales y ambos CSV aparecen en la ruta elegida.
