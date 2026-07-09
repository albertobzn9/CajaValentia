# CMC Protocol

<a id="overview"></a>

## Propósito Del Documento

Este documento reúne las guías de protocolo CMC sin resumir contenido. Sirve como manual base para entender el paradigma experimental, las fases de entrenamiento, la estructura de los ensayos y la relación entre el protocolo, el video y los archivos `.mat`.

> Documento base para entender el paradigma experimental.
> Si eres nuevo, empieza aquí.
> Si tienes duda de una fase, ve directo a la que te interese.

## Idea Central De La Tarea

Una rata motivada debe decidir si **cruza una rejilla electrificada** para llegar a la recompensa (comida) que está del otro lado. ¿Cruza o no cruza? Eso es todo.

## Caja Conductual

Es un pasillo largo dividido en tres zonas:

```
┌─────────────┬─────────────────────────────┬─────────────┐
│  ZONA SEGURA│       ZONA DE AMENAZA       │  ZONA SEGURA│
│  (izquierda)│       (rejilla metálica)    │  (derecha)  │
│             │                             │             │
│  💡 luz     │┌───────┐                    │  💡 luz     │
│  🕹️ palanca ││ TOPE  │ 🔊 Ruido Blanco    │  🕹️ palanca │
│  🍚 comedero│└───────┘     (LED rojo)     │  🍚 comedero│
└─────────────┴─────────────────────────────┴─────────────┘
```

- **Dos zonas seguras** (extremos): ahí está el comedero, la palanca y una luz
- **Una zona de amenaza** (centro): el piso es una rejilla que da descarga
- En el protocolo original, el pasillo mide 100 × 30 × 50 cm; cada zona segura mide 20 × 30 cm y la zona de amenaza mide 60 × 30 cm.
- **Un tope de 9cm** entre la zona segura y la rejilla: la rata tiene que pasar por encima para cruzar (ahí tiende a dudar, hace *SAP*)
- **Luz en los costados**: Indica la disponibilidad de comida en ese lado de la caja.
- **Ruido blanco**: Indica que la parrilla eléctrica está encendida (no tenemos audio en los videos, pero el LED rojo en la parte superior derecha del video nos muestra cuando hay ruido blanco)

Cuando se enciende la **luz** en un extremo indica que hay comida disponible. La rata debe cruzar y presionar la **palanca** para obtener la comida (pellet de sacarosa) que cae en el **comedero**. La luz se puede encender del mismo lado o del lado contrario. Por lo tanto tenemos eventos donde la rata cruza y eventos donde no cruza.

## Estructura De Un Ensayo

**Paso 1 — La rata está en uno de los dos extremos en la zona segura**

**Paso 2 — Se enciende la señal del evento**

- Si la luz se enciende del lado opuesto, la rata tiene que **cruzar la rejilla** para llegar a la comida.
- Si la luz se enciende del mismo lado donde ya está la rata, puede haber palanqueo sin cruce real.

Como contexto de sesión, el primer ensayo siempre es seguro/de comida. Esto sirve como referencia experimental, pero para el programa no sustituye la detección de luces ni la lectura del `.mat`.

Si se enciende el **LED de ruido blanco**, significa que hay **descarga** en la rejilla. Es un ensayo de **conflicto** o riesgo. En estos ensayos, el LED y el ruido blanco se encienden primero; unos segundos después se prende la luz de comida. Este delay fue diseñado a propósito para que la rata sepa de antemano que hay amenaza antes de decidir si cruza por comida.

Punto importante para análisis: en MATLAB, el evento empieza a correr cuando se prende la **luz de comida**, no cuando se prende el LED de ruido. En video, el clip puede conservar el periodo de advertencia LED/ruido → luz para no perder contexto.

**Paso 3 — La rata decide**

- ✅ **Cruza**: pasa la rejilla, presiona la palanca y come
- ❌ **No cruza**: se queda donde está. Después de **180 segundos** la luz se apaga (timeout)

**Paso 4 — Se apaga la luz** → termina el ensayo/evento → empieza el ITI (inter-trial interval, sin luces relevantes) → luego el siguiente ensayo/evento.

**Paso 5 - Sucede otro ensayo**

- Puede ser del mismo lado (hasta tres veces) o que suceda del otro lado, en cuyo caso pasamos de nuevo al paso 1. Esta regla puede aparecer en CS, CP y DIS.
- Esto sucede para evitar que la rata aprenda a hacer ping pong.

## Línea De Tiempo De Una Sesión

Un video de una sesión se ve así en el tiempo:

```
[HABITUACIÓN INICIAL] → [Evento/ensayo 1 seguro] → [ITI] → [Hasta 2 eventos más del mismo lado] → [ITI] → [Evento/ensayo 2] → [Hasta 2 eventos más del mismo lado] → [ITI] → ... → [Evento/ensayo final] → [HABITUACIÓN FINAL]
```

- **Habituación:** en el protocolo original las sesiones inician y terminan con 5 min de exposición al contexto sin luces, ruido ni descarga. En los videos reales del laboratorio, sobre todo al final, esta habituación puede variar porque el corte es manual (por ejemplo ~3–8 min); el programa debe mostrar la duración real y no asumir que siempre son 5 min exactos.
- **Ensayo/evento:** desde que se enciende la señal relevante hasta que se apaga la luz. En ensayos seguros, la señal relevante es la luz de comida. En ensayos de riesgo/conflicto, el LED/ruido puede prenderse unos segundos antes que la luz de comida; MATLAB empieza a contar desde la luz de comida.
- **ITI:** intervalo entre ensayos/eventos, sin luces relevantes. En CS y DIS puede ser corto en los videos reales; en CP puede ser largo y por eso también es importante conservarlo si se quiere segmentar todo el video.

Para el **Video Batch Processor**, la clave está en detectar cuándo se enciende y apaga cada luz para saber dónde cortar.

## Fases Del Protocolo

El entrenamiento completo dura **31 días**. Cada día es una sesión.

| # | Fase | Días | ¿Qué aprende la rata? | Código | Guía |
|---|------|------|-----------------------|--------|------|
| 1 | **Luz-Comida** | 1–6 | Luz = hay comida. Sin luz = no hay comida. Confinada en un extremo, sin cruzar. | `lc` `f1` | [guía](#phase-f1) |
| 2 | **Cruces Seguros (CS)** | 7–11 | Cruzar al lado opuesto cuando la luz se enciende (sin descarga). 30 ensayos/sesión. | `cs` `f2` | [guía](#phase-cs) |
| 3 | **Condicionamiento al Miedo (CM)** | 12–16 | Ruido blanco = descarga. Se congela. | `cm` `f3` | [guía](#phase-cm) |
| 4 | **Cruces Peligrosos (CP)** | 17–21 | Cruzar a pesar de la descarga. Solo conflicto. Duración aumenta: 30s→120s. ~8 ensayos/sesión. | `cp` `f4` | [guía](#phase-cp) |
| 5 | **Discriminación (DIS)** ⭐ | 22–30 | Distinguir ensayos seguros (solo luz) de conflicto (LED/ruido + luz). 30 ensayos/sesión. | `dis` `f5` | [guía](#phase-dis) |
| 6 | **Prueba (PB)** | 31 | Igual que DIS pero sin descarga. Solo memorias. 10 ensayos. | `pb` `f6` | None |

> ⭐ **Discriminación** es la fase más importante para el Video Batch Processor: ahí están las conductas que se desean analizar (conductas de decisión ante conflicto).

## Archivo `.mat` Y Nomenclatura

Cada sesión genera un archivo `.mat` con todos los eventos registrados (prensadas de palanca, cruces, timeouts). El formato es un array de **N filas × 8 columnas**.

Cada fila NO es un ensayo — es un **evento de palanqueo** (la rata puede presionar la palanca varias veces del mismo lado, hasta 3 veces, en CS, CP y DIS).

Las 8 columnas se explican en detalle aquí:
👉 **[Guía del formato .mat](../reference/mat-format.md)**

Los archivos (`.mat`, `.mp4`) pueden seguir distintas nomenclaturas según el momento del proyecto: legacy, estándar del lab u output del Video Batch Processor.

👉 **[Guía de nomenclatura](../reference/naming-convention.md)**

Para evitar ambigüedad entre evento, ensayo, cruce, no cruce y timeout, usar la [convención operativa de términos](../reference/operational-terms.md).

## Guías Por Fase

Las siguientes secciones detallan cada fase del protocolo y su relevancia para el Video Batch Processor.

<a id="phase-f1"></a>

### F1 — Luz-Comida (días 1–6)

> 🔗 Volver a [visión general](#overview)

#### ¿Qué pasa?

La rata está **confinada en un extremo** de la caja (no puede cruzar). Aprende que:

- **Luz encendida** → presiono la palanca → cae un pellet 🍚
- **Luz apagada** → presiono la palanca → no cae nada

Cada sesión tiene ~10 ensayos con luz y ~10 sin luz, en 30 minutos.

#### ¿Qué .mat genera?

**No hay archivo .mat de cruces** para esta fase. Los datos son presión de palanca por minuto y se guardan en un archivo de Excel.

#### ¿Para qué sirve?

Es la base: la rata aprende que la luz = comida. Sin esto, no entiende que después tenga que cruzar hacia la luz.

**Nota:** usualmente no hay video de esta fase.

<a id="phase-cs"></a>

### F2 — Cruces Seguros / CS (días 7–11)

> 🔗 Volver a [visión general](#overview)

#### ¿Qué pasa?

La rata ahora tiene acceso a toda la caja. Puede **cruzar de un extremo al otro**. Una luz se enciende en el **lado opuesto** y la rata cruza la rejilla (sin descarga), presiona la palanca y cae el pellet.

- **30 ensayos por sesión**
- **Sin descarga** — la descarga eléctrica no está activa
- La rata cruza **rápido** (~8 segundos al final del entrenamiento)
- Dado que la rata cruza rápido, casi **no hay timeouts de 180s**, salvo en los primeros ensayos del primer día en algunas ocasiones.

#### El .mat

Misma estructura de 8 columnas que DIS, pero con una diferencia clave: casi nunca hay **Lado=-2** y no hay estímulo eléctrico, es decir `Estim=0`.

▶️ **[Ver formato .mat](../reference/mat-format.md)** para la descripción de las columnas.

##### Ejemplo: `exp_0126_cs_d5r1.mat`

```
Ensayo | Lado | Estim | Latencia | TiempoAbs | PalI | PalD | Desplaz
   1   |  0   |   0   |   8.12   |   315.3   |  0   |  1   |  4.92
   2   |  0   |   0   |   1.85   |   323.0   |  0   |  2   |  0.15
   3   |  1   |   0   |   6.06   |   334.8   |  1   |  2   |  4.25
```

Observa que en el ensayo dos la luz se encendió del mismo lado que el ensayo uno y por lo tanto `Desplaz < 1`.

- `Estim` siempre 0 (no hay descarga)
- `Latencia` baja (~1–12s)
- `Desplaz` puede ser < 1 en eventos de palanqueo sin cruce
- No hay filas con 180s

#### En el video

- Rata cruza repetidamente la rejilla
- Solo se enciende la **luz de comida** (izquierda o derecha)
- **LED de ruido** siempre apagado
- La rata se mueve con confianza, pocas dudas en el tope

#### Para el Video Batch Processor

- Detectar luz de comida → saber lado y duración del ensayo
- No necesita distinguir seguro/conflicto (todo es seguro)
- Distinguir entre eventos del mismo lado donde no hay cruce y eventos donde sí lo hay, de tal modo que se puedan categorizar los clips con cruce, sin cruce e ITI.

<a id="phase-cm"></a>

### F3 — Condicionamiento al Miedo / CM (días 12–16)

> 🔗 Volver a [visión general](#overview)

#### ¿Qué pasa?

La rata está **confinada en la zona central** (la rejilla). No puede ir a los extremos. Aprende que:

- **Ruido blanco** (30s) → **descarga** (0.5 mA, 1s)
- El ruido blanco se señala en el video con un **LED rojo**

Días 12–15: 5 pares ruido-descarga por sesión.
Día 16: prueba de memoria — 2 ruidos **sin descarga**. La rata se congela (~60%).

#### ¿Qué .mat genera?

**No hay archivo .mat de cruces.** Los datos son porcentaje de congelamiento (*freezing*), no latencias. El Video Batch Processor no procesa esta fase directamente.

#### En el video

- Rata siempre en el centro (rejilla)
- LED rojo se enciende → ruido blanco → rata se congela
- No hay ensayos de cruce
- No hay luces de comida encendidas

#### ¿Para qué sirve?

Sin esta fase la rata no le tiene miedo al ruido blanco que se asocia con la descarga eléctrica en la rejilla. Es lo que permite que después, en DIS, la rata **dude** antes de cruzar.

<a id="phase-cp"></a>

### F4 — Cruces Peligrosos / CP (días 17–21)

> 🔗 Volver a [visión general](#overview)

#### ¿Qué pasa?

La rata debe **cruzar la rejilla a pesar de la descarga**. Todos los ensayos son de conflicto/riesgo.

En CP, el LED de ruido blanco y el sonido se encienden primero. Unos segundos después se prende la luz de comida. No son señales simultáneas: el delay existe para avisarle a la rata que hay amenaza antes de que aparezca la comida. En MATLAB, la latencia del evento empieza cuando se prende la luz de comida.

La duración de cada ensayo **aumenta progresivamente**, si la rata no cruza en el tiempo máximo el ensayo se acaba:

| Día | 17 | 18 | 19 | 20 | 21 |
|-----|----|----|----|----|----|
| Duración Máxima | 30s | 30s | 60s | 90s | 120s |

- ~8 ensayos por sesión (la sesión dura 30 min)
- **Solo conflicto** — no hay ensayos seguros mezclados
- La rata aprende a limitar su tiempo de cruce

#### El .mat

Misma estructura de 8 columnas. Aquí `Estim` **siempre es 1** (todos son conflicto). Aparecen timeouts cuando la rata no alcanza a cruzar en el tiempo límite del día.

▶️ **[Ver formato .mat](../reference/mat-format.md)** para la descripción de las columnas.

##### Ejemplo: `exp_0126_cp_d5r1.mat`

```
Ensayo | Lado | Estim | Latencia | TiempoAbs | PalI | PalD | Desplaz
   1   |  1   |   1   |  12.45   |   1200.5  |  0   |  1   |  4.92
   2   |  0   |   1   | 120.00   |   1330.2  |  1   |  2   |  120.0  ← timeout (día de 120s)
```

- `Estim` siempre 1
- `Latencia` puede llegar hasta el límite del día (timeout)
- No hay mezcla seguro/conflicto — todo es conflicto

#### En el video

- LED de ruido/sonido se encienden primero y, unos segundos después, se prende la luz de comida
- La rata duda en el tope, hace SAP, va y viene
- Si no cruza a tiempo, la luz se apaga sola (timeout)
- La rata se queda en el lado donde empezó

#### Para el Video Batch Processor

- Detectar el periodo LED/ruido previo a la luz de comida
- Saber que todos los ensayos son de conflicto
- Detectar timeouts: si la luz dura exactamente el límite del día, la rata no cruzó

<a id="phase-dis"></a>

### F5 — Discriminación / DIS (días 22–30) ⭐

> 🔗 Volver a [visión general](#overview)

#### ¿Qué pasa?

⚠️ **Esta es la fase más importante.** Aquí se generan las conductas que se quieren analizar. Sin embargo, las tres fases son importantes (cs, cp, dis).

La rata debe **distinguir** entre dos tipos de ensayos **mezclados al azar**:

| Tipo | Luces | Descarga | ¿Cruza? |
|------|-------|----------|---------|
| 🟢 **Seguro** | Solo luz de comida | No | ✅ Rápido (~20s) |
| 🔴 **Conflicto** | LED ruido primero + luz de comida después | Sí | ❌ Duda, a veces timeout (180s) |

- **30 ensayos/eventos por sesión** (3 bloques de 10)
- El primer ensayo de la sesión siempre es seguro/de comida; esto es contexto experimental, no una regla que reemplace la detección de luces.
- Cuando la rata no cruza ni siquiera en ensayos seguros, se detiene la sesión después de 35 min (por lo tanto no se cumplen los 30 ensayos de cruces)
- Progresión: días 22–24 → 10% conflicto (3/30) · 0.5mA
  Días 25–27 → 30% conflicto (9/30) · 0.5mA
  Días 28–30 → 30% conflicto · 0.6, 0.7 y 0.8mA respectivamente.
- **Cada ensayo dura máximo 180s**
- La rata termina discriminando: latencia alta en conflicto (~82s) vs baja en seguro (~23s)

#### El .mat

Misma estructura de 8 columnas. Cada sesión tiene un archivo .mat con **~40–80 filas** (cada presión de palanca + cruce + timeout es un evento).

▶️ **[Ver formato .mat](../reference/mat-format.md)** para la descripción detallada de las columnas.

##### Ejemplo: `exp_0126_dis_d9r4.mat` (día 9, rata 4)

```
Ensayo | Lado | Estim | Latencia | TiempoAbs | PalI | PalD | Desplaz | Significado
   1   |  0   |   0   |   8.12   |   315.3   |  0   |  1   |  4.92   | 🟢 Seguro, luz izq, cruzó
   4   |  0   |   1   |   5.85   |   348.2   |  1   |  3   |  2.06   | 🔴 Conflicto, luz izq, cruzó
   7   | -2   |   1   | 180.60   |   551.6   |  1   |  5   | 180.00  | 🔴 Conflicto, ❌ NO cruzó (timeout)
   8   |  1   |   0   |   0.95   |   557.6   |  2   |  5   |  0.30   | 🟢 Seguro, luz der, palanqueo sin cruce
```

**Datos clave de este .mat:**

- 79 filas totales (eventos de palanqueo + cruces + timeouts)
- 12 ensayos de conflicto (30%)
- 12 timeouts (Lado=-2, Latencia≈180s)
- Algunos timeouts son de conflicto, otros de seguro (rata ya no quiso cruzar)
- Puede haber hasta 3 eventos del mismo lado seguidos

#### En el video

- **Secuencia segura típica:** luz se enciende → rata decide/palanquea → luz se apaga → ITI → siguiente evento/ensayo
- **Secuencia conflicto típica:** LED/ruido se enciende → delay → luz de comida se enciende → rata duda en el tope → decide (cruza o no) → luz se apaga → ITI → siguiente evento/ensayo
- LED/ruido + luz de comida → conflicto. Solo luz de comida → seguro.
- Si el evento/ensayo dura ~180s → la rata no cruzó
- 3 ensayos seguidos del mismo lado pueden ocurrir

#### Para el Video Batch Processor

⚠️ **Lo más importante:**

1. **Detección de luces** → el programa debe distinguir:
   - Luz izquierda ON/OFF
   - Luz derecha ON/OFF
   - LED ruido ON/OFF
2. **Duración del ensayo** = desde que se enciende la luz hasta que se apaga
3. **En ensayos de conflicto** el LED del ruido blanco se enciende antes que la luz de comida. Para video, conviene conservar ese periodo de advertencia; para MATLAB, la latencia empieza cuando se prende la luz de comida.
4. **Tipo** = con LED ruido es conflicto, sin LED es seguro
5. **Cruce** = necesita cotejar con .mat (latencia real) o inferir por timing
6. **Incluir timeouts** (Lado=-2) — esos ensayos también se recortan
7. **ITIs** entre ensayos/eventos. Pueden ser cortos en CS/DIS y largos en CP.

## Glosario

| Término | Significado |
|---------|-------------|
| **CS** | Cruces Seguros (no hay descarga) |
| **CP** | Cruces Peligrosos (hay luz y ruido blanco, duración limitada) |
| **DIS** | Discriminación (ensayos mezclados seguro/conflicto) |
| **PB** | Prueba (igual que DIS, sin descarga) |
| **ITI** | Inter-Trial Interval (tiempo entre ensayos/eventos, sin estímulos relevantes) |
| **SAP** | Stretch Attend Posture (la rata estira el cuerpo hacia la rejilla sin cruzar — conducta de evaluación de riesgo) |
| **Timeout** | Ensayo donde la rata no cruzó en 180s |
| **Tope** | Barrera de 9cm que separa zona segura de la rejilla |
| **Lado -2** | En el .mat, significa que la rata no cruzó |

## Referencias Internas

- Si trabajas con **Discriminación** (la fase principal): [guía DIS](#phase-dis)
- Para distinguir evento, ensayo, cruce, no cruce y timeout: [convención operativa de términos](../reference/operational-terms.md)
- Si necesitas entender el .mat a fondo: [guía del formato .mat](../reference/mat-format.md)
- Para entender los nombres de los archivos: [guía de nomenclatura](../reference/naming-convention.md)
- Para el resto de fases: [Luz-Comida](#phase-f1) | [CS](#phase-cs) | [CM](#phase-cm) | [CP](#phase-cp)
