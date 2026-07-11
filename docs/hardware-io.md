# Mapa IO / Hardware De La Caja Valentia

Este documento resume el contrato de hardware inferido del MATLAB vivo. No
reemplaza una prueba fisica con multimetro/caja. Sirve para saber que funciones
tocan que lineas y que debe verificarse antes de modificar control de hardware.

## Inicializacion General

Archivo: `docs/source_code_matlab_valentia/MATLAB/Valentia/OA_ValentiaInicio.m`

El codigo crea:

```matlab
dio = digitalio('nidaq','Dev2');
addline(dio, 0:7, 0, 'In');
addline(dio, 0:7, 1, 'Out');
addline(dio, 0:7, 2, 'Out');
```

Lectura practica:

| Lineas MATLAB | Puerto NI | Direccion | Uso general |
| --- | --- | --- | --- |
| `1:8` | puerto 0 | entrada | sensores / contadores leidos despues de seleccionar modo. |
| `9:16` | puerto 1 | salida | selector de lectura, descarga y reset de palancas. |
| `17:24` | puerto 2 | salida | bus de estimulos, dispensadores y actuadores. |

`escribePto(OA, BE, DE)` escribe sobre `OA.Line(9:24)`. Por eso el codigo usa
numeros logicos 9-24, no indices 1-16.

## Lineas De Salida 9-16

| Linea(s) | Funcion observada | Comentario |
| --- | --- | --- |
| `9:12` | selector de lectura/multiplexor | Cambia que senales aparecen en entradas `1:8`. |
| `13:14` | descarga electrica | `OA_ValentiaElectrico`: `[1 1]` = encendida, `[0 0]` = apagada. |
| `16` | reset de contadores de palanca | Pulso `0 -> 1 -> 0` en `OA_ValentiaResetPalancas`. |

La linea 15 no aparece como uso central en las rutas activas revisadas.

### Selectores En `9:12`

| Valor escrito en `9:12` | Funcion | Lectura posterior |
| --- | --- | --- |
| `[1 1 0 0]` | revisar palancas | `OA_ValentiaRevisaPalanca` lee entradas `1:8`. |
| `[0 1 0 0]` | buscar llegada/cruce izquierda | `OA_ValentiaBuscaIzquierda` usa entradas `1:2`, activo bajo. |
| `[0 0 0 0]` | buscar llegada/cruce derecha | `OA_ValentiaBuscaDerecha` usa entradas `2:4`, activo bajo. |

Hay otras funciones historicas de posicion que usan valores adicionales, pero no
son el centro del flujo del manual.

## Entradas 1-8

Las entradas se interpretan distinto segun el selector en `9:12`.

### Palancas

Archivo: `OA_ValentiaRevisaPalanca.m`

Con selector `[1 1 0 0]`:

- entradas `1:4` se decodifican como contador derecho (`DD`);
- entradas `5:8` se decodifican como contador izquierdo (`DI`);
- el orden de bits no es directo: usa `a(4), a(3), a(1), a(2)`.

Esto sugiere que los contadores externos no estan cableados en orden binario
natural. No se debe "simplificar" esa decodificacion sin probarlo.

### Sensores De Cruce

Archivos:

- `OA_ValentiaBuscaIzquierda.m`
- `OA_ValentiaBuscaDerecha.m`

Lectura observada:

- izquierda: selector `[0 1 0 0]`, entradas `1:2`, activo bajo;
- derecha: selector `[0 0 0 0]`, entradas `2:4`, activo bajo.

El codigo usa `not(DatosL(...))`, asi que una senal fisica baja se interpreta
como deteccion.

## Lineas 17-23: Bus De Estimulos Y Actuadores

Las funciones arman un vector de 7 bits:

```matlab
CD = [control Datos]
escribePto(OA, 17:23, CD)
```

Donde:

- `control` tiene 3 bits;
- `Datos` tiene 4 bits.

El patron general parece ser:

1. poner datos con `control = [0 0 0]`;
2. mandar pulso con algun `control`;
3. volver a `control = [0 0 0]`.

## Estimulos Izquierdo/Derecho

Archivos:

- `OA_ValentiaEstimuloI.m`
- `OA_ValentiaEstimuloD.m`

Parametros:

| Parametro | Valor | Significado |
| --- | --- | --- |
| `Sonido` | `0` | apagado |
| `Sonido` | `1` | continuo |
| `Sonido` | `2` | intermitente |
| `Luz` | `0` | apagada |
| `Luz` | `1` | continua |
| `Luz` | `2` | intermitente |

Codificacion de `Datos`:

| Bits de datos | Uso |
| --- | --- |
| `Datos(1:2)` | sonido/LED: `[0 0]` apagado, `[1 1]` activo. |
| `Datos(3:4)` | luz: `[0 0]` apagada, `[1 0]` continua, `[0 1]` intermitente. |

Control:

| Funcion | Control usado |
| --- | --- |
| estimulo izquierdo | `[1 1 0]` |
| estimulo derecho | `[1 0 0]` |

Nota: los nombres izquierdo/derecho deben validarse con la caja, porque en las
GUIs de cruces hay lugares donde la lectura del lado no es intuitiva.

## Descarga Electrica

Archivo: `OA_ValentiaElectrico.m`

| Control | Lineas `13:14` |
| --- | --- |
| descarga apagada | `[0 0]` |
| descarga encendida | `[1 1]` |

Requisito de seguridad: cualquier paro, error o cierre debe ejecutar apagado de
descarga antes de soltar la sesion.

## Recompensa / Dispensadores

Archivos:

- `OA_ValentiaRecompensaI.m`
- `OA_ValentiaRecompensaD.m`
- `OA_CtrlDispIzqCero.m`

Control observado para dispensador:

| Funcion | Control |
| --- | --- |
| pulso de recompensa / dispensador | `[1 0 1]` |

Datos observados:

| Funcion | Datos usados |
| --- | --- |
| recompensa izquierda | alterna `[0 0 0 0]` y `[1 0 0 0]` |
| recompensa derecha | alterna `[0 1 0 0]` y `[0 0 0 0]` |
| limpiar/zero dispensador | `[0 0 0 0]` |

Esto debe validarse fisicamente, porque los nombres I/D dependen del cableado y
de la convencion historica del programa.

## Palancas Retractiles

Archivo: `OA_ValentiaPalanca.m`

La funcion existe y usa el mismo bus `17:23`.

| Lado | Control |
| --- | --- |
| palanca derecha | `[0 1 0]` |
| palanca izquierda | `[0 0 1]` |

Datos:

| Lado | Mostrar | Ocultar |
| --- | --- | --- |
| derecha | `Datos(3:4) = [0 1]` | `Datos(3:4) = [1 0]` |
| izquierda | `Datos(3:4) = [1 0]` | `Datos(3:4) = [0 1]` |

En las rutas actuales algunas llamadas a palancas estan comentadas o se usan
solo al inicio. Antes de tratarlas como requisito operacional, conviene confirmar
si la caja actual todavia usa retraccion real de palancas.

## Audio

Archivos:

- `OA_PreparaSonidos.m`
- `OA_Sonidos.m`

El audio usa:

```matlab
analogoutput('winsound', 0)
addchannel(GS, [1 2])
SampleRate = 20000
```

`OA_Sonidos(GS, Duracion, fI, AI, fD, AD)` genera audio estereo:

- canal 1: lado izquierdo;
- canal 2: lado derecho;
- frecuencia `<= 10000`: tono senoidal;
- frecuencia `> 10000`: ruido aleatorio;
- amplitud de 0 a 1 segun parametros.

Por eso el uso de `15000` en el manual corresponde a ruido blanco en el codigo.

### Verificacion Real

El 2026-07-11 se ejecuto `cmc_prueba_audio_estereo` en MATLAB R2011a de la
computadora del laboratorio. El operador confirmo salida solo izquierda y luego
solo derecha. La funcion que se ejecuto provino de la copia aislada del
Escritorio. Por tanto, si durante una sesion parece sonar del lado equivocado,
primero confirmar la atencion al lado y el contexto del evento; no hay evidencia
actual de que MATLAB duplique el audio en ambas bocinas.

## Linea 24

`OA_ValentiaInicio`, `OA_CtrlDispIzq` y `OA_CtrlDispIzqCero` escriben `0` en la
linea `24`. No encontre en las rutas activas un significado comentado claro.

Tratar como linea reservada/limpieza de hardware hasta probar fisicamente.

## Verificaciones Criticas En Caja Real

Antes de tocar control de hardware, confirmar:

- que `I` y `D` correspondan a izquierda/derecha fisicas en luces, audio,
  sensores y dispensadores;
- que `OA_ValentiaElectrico(0)` realmente apague la descarga;
- que una interrupcion del programa no deje la descarga latcheada;
- que la linea 24 no active nada peligroso;
- que sensores de cruce sigan siendo activo bajo;
- que dispensadores entreguen un pellet por pulso;
- que contadores de palanca no saturen o den rollover inesperado.

## Resumen Operativo

La caja no se controla con comandos independientes simples; se controla con un
bus historico:

- `9:12` selecciona que se lee;
- `13:14` controla descarga;
- `16` resetea palancas;
- `17:23` manda comandos a estimulos, dispensadores y palancas;
- `1:8` devuelve sensores/contadores segun el selector;
- audio va por `winsound`, no por NI-DAQ.

Este mapa es suficiente para entender el MATLAB actual. Para cualquier software
que opere la caja, el siguiente paso obligatorio seria validar este mapa con la
caja fisica antes de confiar en el control automatico.
