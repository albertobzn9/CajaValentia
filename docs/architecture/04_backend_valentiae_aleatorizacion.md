# Que Hace `ValentiaE` Detras De La GUI

Esta guia explica la version estable del programa: `06_matlab_limpio_usb`.
No necesitas leer codigo para usarla.

## Idea Central

`ValentiaE` primero decide una secuencia de lados. Despues decide cuales
cambios de lado son seguros o de riesgo. Solo entonces corre cada evento.

```text
lado -> cambio o repeticion -> seguro o riesgo -> luz/ruido/parrilla
```

## El Campo De Riesgo

El valor de riesgo se escribe como decimal:

| Valor | Intencion |
|---|---|
| `0` | Cruces seguros: sin riesgo. |
| `0.1` | Un riesgo por cada diez cambios de lado. |
| `0.3` | Tres riesgos por cada diez cambios de lado. |

El programa trabaja en grupos de diez cambios de lado. Solo puede poner un
numero entero de riesgos dentro de cada grupo. Por eso redondea:

| Valor escrito | Lo que realmente usa |
|---|---|
| `0.10` | 1 riesgo por 10 cambios |
| `0.15` | 2 riesgos por 10 cambios |
| `0.20` | 2 riesgos por 10 cambios |
| `0.25` | 3 riesgos por 10 cambios |
| `0.30` | 3 riesgos por 10 cambios |

Por eso `0.15` no representa 15% exacto en esta version. Se comporta como
20% de los cambios de lado.

## Que Significa “Aleatorizar”

Hay dos aleatorizaciones automaticas:

1. Se alternan los lados con repeticiones limitadas. La rata puede recibir
   uno, dos o hasta el maximo configurado de eventos seguidos en el mismo lado.
2. Dentro de cada grupo de diez cambios de lado, se sortean las posiciones de
   los riesgos. El porcentaje decide cuantos; el sorteo decide donde caen.

Aleatorizar cambia el orden, no el numero de riesgos de un bloque completo.

## Cambio De Lado Y Mismo Lado

No todos los eventos implican cruzar.

```text
Izquierda -> Izquierda = mismo lado: evento seguro de comida.
Izquierda -> Derecha   = cambio de lado: puede ser seguro o de riesgo.
```

Esta regla es importante: los riesgos solo se asignan a cambios de lado. Un
evento repetido en el mismo lado no activa ruido ni parrilla.

Por eso, los primeros 30 eventos de la GUI no tienen necesariamente nueve
riesgos cuando se usa `0.3`: dependen de cuantos cambios de lado ocurrieron
antes de parar la sesion.

## El Campo De 300 Ensayos

El campo normalmente se deja en `300`, pero no decide la secuencia ni el
porcentaje de riesgo. El programa genera por dentro una secuencia de 1000
eventos y usa `300` solamente como limite automatico de paro.

Entonces:

- poner `30` o `300` no cambia los primeros eventos de una misma secuencia;
- `30` hace que el programa se detenga solo despues de 30;
- `300` permite que el operador la detenga manualmente antes, como hace el lab.

## Lo Que El Programa Si Y No Garantiza

| Si garantiza | No garantiza |
|---|---|
| Riesgo solo cuando cambia el lado. | Un porcentaje exacto dentro de los primeros 30 eventos visibles. |
| `0.1` y `0.3` exactos por cada diez cambios. | Que `0.15` sea 15% exacto. |
| Orden aleatorio de riesgos dentro de cada bloque de cambios. | Que dos sesiones tengan el mismo orden. |

## Regla Para El Nuevo Sonido Solo

La copia experimental sigue la misma idea: sonido solo tambien debe aparecer
solo cuando cambia el lado. Su diseno tecnico esta en
[Handoff de sonido solo](../../12_matlab_experimental_discriminacion_sonido_solo/HANDOFF_TECNICO.md).

## Si Alguien Necesita Revisar El Codigo

- GUI y bucle de sesion: `OA_ValentiaCuatroE.m`.
- Lados y cambios: `Valentia/OA_Secuencia.m`.
- Riesgo sobre cambios: `Valentia/OA_SecuenciaEnsayos3.m`.
- Redondeo y sorteo: `Valentia/OA_ValentiaRiesgo.m`.
