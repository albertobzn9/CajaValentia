# Requisitos De GUI

## Regla Comun

Usar controles compatibles con MATLAB R2011a/GUIDE. `uicontrol` soporta
`togglebutton`. El futuro selector debe leerse asi:

- presionado: `LEGACY`;
- sin presionar: `ACTUAL`;
- bloqueado desde `Iniciar` hasta el fin de la sesion.

El toggle no puede intercambiar backend durante una sesion. Debe indicar el
modo con texto, no solo con color. En esta primera entrega el backend `Actual`
no se conecta: solo se rediseña y prueba la base `V1 limpio`.

La interfaz puede reservar espacio para controles de V2/3, pero no debe
simularlos con V1. En modo V1 esos controles se muestran desactivados y con el
texto `Requiere backend Actual`.

## ValentiaE: Discriminacion

- Dos grupos visibles: ensayo seguro y ensayo de riesgo.
- Tabla central preparada para 10 columnas. Con V1, mostrar solo sus 8 datos
  reales; `Tipo` y `E. cruce` quedan desactivados hasta integrar V2/3.
- Columna lateral compacta: porcentaje de riesgo, maximo de repeticiones,
  habituacion y reloj. `Agregar evento sonido 1:10` queda desactivado con la
  nota `Requiere backend Actual`.
- Botones: `Iniciar`, `Detener ahora` y `Guardar datos`. `Detener tras ensayo`
  queda desactivado hasta integrar V2/3.

## ValentiaE2: Cruces Peligrosos

- Debe compartir la misma estructura visual que `ValentiaE`.
- La diferencia visible principal es el cierre por `Conducta (min)`, no por
  `Ensayos de cruce`.
- Los campos existentes de V1 conservan su comportamiento. Los nuevos controles
  de CP (sonido solo temporal, limite 30+10 s y parada tras ensayo) quedan
  desactivados hasta integrar V2/3.

## EntrenaE: Luz / Oscuridad

- Acciones claras: iniciar, pellet, reiniciar contadores y guardar datos.
- Mostrar estados de palanca izquierda/derecha.
- Mostrar contadores de tiempo y palanqueos con luz, sin luz y total.
- Separar visualmente parametros editables de parametros bloqueados durante una
  sesion.

## Wishlist: No Implementar Sin Aprobacion

Los bocetos tambien mencionan: sustituir columnas 6/7, registrar lado de
inicio, registrar rata/dia/tarea y cambiar ITI de CP. Son decisiones de datos o
conducta; documentarlas como propuestas, pero no cambiarlas dentro del primer
rediseño de GUI.
