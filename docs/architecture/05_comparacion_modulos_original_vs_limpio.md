# Comparacion De Modulos: Original Vs Limpio

## Resumen

La comparacion util es contra la copia original que MATLAB usaba en:
`legacy/fsotres/MATLAB`.

| Version | Archivos `.m` | Lectura |
|---|---:|---|
| Original activo | 104 | Carpeta de ejecucion antigua; mezcla codigo vigente y legado. |
| MATLAB limpio | 49 | Copia portable actual. |
| Reduccion | 55 menos (53%) | Se conserva lo necesario para las tareas actuales y hardware. |

El respaldo completo tiene **191** archivos `.m`, pero no son 191 modulos
distintos: contiene una segunda copia antigua en `Documents/MATLAB` (86
archivos) y `pathdef.m`. Hay 87 nombres repetidos. Esa duplicacion era una
fuente real de menus y funciones viejas cargadas por accidente.

## MATLAB Limpio: 49 Modulos

| Categoria | Cantidad | Que contiene |
|---|---:|---|
| Tareas operativas | 5 | Condicionamiento, entrenamiento de palancas, ValentiaE y ValentiaE2. |
| Logica experimental | 7 | Riesgo, secuencias, y eventos de solo sonido. |
| Hardware y audio | 17 | Tarjeta NI, sensores, luces, parrilla, palancas, pellets y audio. |
| Arranque, rutas, resultados y apoyo GUI | 12 | `abrir1`, aislamiento de rutas, tabla y guardado. |
| Pruebas y simulaciones controladas | 8 | Diagnosticos de audio, tabla, secuencia y simulacion sin hardware. |
| **Total** | **49** | |

Los 8 modulos de prueba no aparecen en el menu normal. Estan para validar el
programa sin volver a explorar el codigo cada vez que haya un cambio.

## Que Se Excluyo Del Original Activo

De los 100 nombres unicos de la copia original activa, 27 se conservaron con el mismo nombre y 22
modulos nuevos se agregaron para aislamiento portable, validacion y sonido
solo. Quedaron fuera 73 nombres del original:

| Categoria excluida | Cantidad | Ejemplos | Interpretacion |
|---|---:|---|---|
| Versiones antiguas de programas | 14 | `OA_ValentiaCuatroB`, `...E3`, `...F`, `Uno`, `DosCP`, `TresCP` | Iteraciones o protocolos previos; no son el flujo diario actual. |
| Variantes de secuencia, riesgo y audio | 15 | `OA_SecuenciaEnsayos2`, `...Conflicto`, `OA_RiesgoNeutros`, `OA_PreparaSonidosA` | Experimentos/prototipos alternativos no usados por el manual. |
| Capa antigua de sensores y actuadores | 22 | `OA_ValentiaPosicion*`, `...Recompensa*_est`, `...EstimuloAlerta` | Implementaciones previas o auxiliares, sustituidas por los 10 drivers de hardware vigentes. |
| Entrenamientos, analisis y pruebas historicas | 22 | `Analizar`, `GraficaValentia`, `OA_CondicionamientoConflicto`, `pruebaA` | Herramientas de otra etapa, diagnosticos sueltos o tareas fuera del alcance actual. |
| **Total fuera** | **73** | | |

"Fuera" no significa necesariamente que cada archivo sea basura. Algunos son
prototipos o evidencia historica. Significa que no forman parte de las tareas
que el manual define como operativas y no deben estar en el path de la copia
de uso diario.

## Conclusiones Operativas

- El programa limpio no es una reescritura: es una seleccion controlada del
  codigo que si funciona, mas utilidades nuevas de seguridad y validacion.
- La estructura `Valentia/valentia` se conserva porque corresponde a la capa
  de hardware y el arranque agrega esas rutas de forma explicita.
- La copia limpia tiene 49 nombres unicos; no hay versiones duplicadas con el
  mismo nombre compitiendo en el path.
- El original queda preservado en `legacy/` para consulta, pero no debe
  ejecutarse durante una sesion experimental.
