# Base De Codigo Entregada

## Usar Solo V1

`runtime-v1-clean/` es una copia completa del tag `v1.0.0`: la version limpia
del programa legacy, antes de los cambios actuales de comportamiento y datos.
Es la unica base de codigo para el rediseño inicial.

Incluye 32 modulos `.m`, sus GUIs `.fig`, archivos de estado y las subcarpetas
necesarias para ejecutar las cinco tareas del menu. Sus puntos de entrada son:

| Tarea | Archivo |
| --- | --- |
| Discriminacion | `OA_ValentiaCuatroE.m` |
| Cruces Peligrosos | `OA_ValentiaCuatroE2.m` |
| EntrenaE | `OA_ValentiaEntrenaPalancasCPE.m` |

V1 conserva el formato legacy de 8 columnas. No contiene las columnas
`tipo_evento`/`ensayo_cruce`, sonido solo, CSV de palanqueos ni los controles
nuevos de V2/3.

## No Usar Para Este Encargo

- `../../legacy/`: V0 original, con variantes y duplicados historicos.
- `../../matlab/`: V2/3 en desarrollo; se entregara cuando el equipo cierre
  sus cambios y Eric pueda integrarla con la nueva GUI.

## Integracion Posterior

Cuando se entregue V2/3, el selector futuro debe elegir una sola raiz de
backend antes de abrir una tarea. Como ambas versiones tendran funciones con
nombres iguales, nunca se deben agregar ambas rutas al MATLAB path.

Hasta entonces, el selector puede existir visualmente como `V1 limpio`, pero
no debe prometer ni intentar abrir un backend Actual ausente.
