# Comparacion De Modulos: Original Vs Runtime Activo

La comparacion util es contra `legacy/fsotres/MATLAB`, la carpeta que MATLAB
resolvia en la PC antigua.

| Conjunto | Archivos `.m` | Lectura |
| --- | ---: | --- |
| Original activo | 104 | Mezcla de codigo vigente, variantes y pruebas antiguas. |
| Runtime actual `matlab/` | 72 | Tareas vigentes, hardware, protecciones de ruta, CSV y pruebas reutilizables. |
| Reduccion neta | 32 menos (31%) | El runtime crecio desde la primera limpieza para incluir seguridad, registro y validacion. |

El archivo completo tiene **191** `.m`: conserva una segunda copia historica en
`legacy/fsotres/Documents/MATLAB`. No se deben deduplicar: el conflicto entre
ambas copias explica por que MATLAB podia abrir menus o funciones viejas.

## Que Hay En Los 72 Modulos Activos

| Grupo | Contenido |
| --- | --- |
| Tareas operativas | Las cinco GUIs del menu, incluida Discriminacion y CP. |
| Logica y hardware | Secuencias, riesgo, audio, tarjeta NI, sensores, luces, pellet, parrilla y palancas. |
| Operacion segura | Arranque aislado, rutas, tabla, CSV, conteo de cruces, habituacion y aviso final. |
| Pruebas | 11 scripts `cmc_prueba_*`/`cmc_simulacion_*` que no aparecen en el menu normal. |

Los modulos nuevos no son basura: reducen dependencia de la PC, registran datos
analizables y permiten validar sin tocar hardware. El detalle de las capas esta
en [el mapa del runtime](matlab-runtime-overview.md).

## Que Se Excluyo Del Original Activo

Quedaron fuera variantes no necesarias para las tareas del manual. Git conserva
la evidencia completa en `legacy/`; el runtime no las agrega al path:

| Categoria excluida | Cantidad | Ejemplos | Interpretacion |
| --- | ---: | --- | --- |
| Versiones antiguas de programas | 14 | `OA_ValentiaCuatroB`, `...E3`, `...F`, `Uno`, `DosCP`, `TresCP` | Iteraciones o protocolos previos. |
| Variantes de secuencia, riesgo y audio | 15 | `OA_SecuenciaEnsayos2`, `...Conflicto`, `OA_RiesgoNeutros`, `OA_PreparaSonidosA` | Prototipos alternativos no usados por el manual. |
| Capa antigua de sensores y actuadores | 22 | `OA_ValentiaPosicion*`, `...Recompensa*_est`, `...EstimuloAlerta` | Implementaciones previas o auxiliares. |
| Entrenamientos, analisis y pruebas historicas | 22 | `Analizar`, `GraficaValentia`, `OA_CondicionamientoConflicto`, `pruebaA` | Herramientas de otra etapa. |

"Fuera" no significa que cada archivo sea basura. Significa que no pertenece a
la ruta diaria definida por el manual.

## Conclusiones Operativas

- El runtime no es una reescritura: es una seleccion controlada del codigo que
  funciona, mas utilidades nuevas de seguridad, registro y validacion.
- La estructura `Valentia/valentia` se conserva porque contiene la capa de
  hardware y el arranque agrega sus rutas de forma explicita.
- `cmc_prepara_entorno_r2011a` evita que versiones duplicadas compitan en el
  path durante el uso diario.
- El original queda preservado en `legacy/` para consulta, pero no debe
  ejecutarse durante una sesion experimental.
