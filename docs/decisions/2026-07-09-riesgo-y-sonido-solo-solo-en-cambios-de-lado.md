# Riesgo Y Sonido Solo Solo En Cambios De Lado

## Contexto

En `ValentiaE`, la secuencia tiene eventos repetidos en el mismo lado y eventos
donde la rata debe cambiar de lado. Los repetidos permiten reforzar palanqueo
sin pedir un cruce nuevo.

## Regla Confirmada

Un evento de riesgo solo puede aparecer cuando cambia el lado. Un evento
repetido en el mismo lado siempre es seguro: luz/comida, sin sonido ni
parrilla.

Esto ya ocurre en el codigo actual:

- `OA_Secuencia` crea lados con repeticiones.
- `OA_SecuenciaEnsayos3` marca como candidatos solo los cambios de lado.
- `OA_ValentiaRiesgo` decide cuales de esos candidatos son de riesgo.

Por eso, el porcentaje de riesgo se aplica a cambios de lado, no a todos los
eventos que el contador de la GUI llama `Ensayo`.

## Decision Para El Nuevo Evento

El evento nuevo de sonido solo debe seguir la misma regla:

```text
Mismo lado: luz/comida segura solamente.
Cambio de lado: puede ser seguro, conflicto o sonido solo.
```

El sonido solo significa ruido blanco, LED marcador y parrilla activa, sin luz
de comida ni pellet. Dura 180 s completos salvo paro manual.

El sonido solo se usa exclusivamente en discriminacion: riesgo mayor que cero
en `ValentiaE`. Con riesgo `0`, `ValentiaE` sigue siendo cruces seguros y no
debe generar riesgo, parrilla ni sonido solo.

## Diseno Confirmado Para Discriminacion

La sesion experimental tendra 33 eventos en total: tres bloques de 11.
Cada bloque contiene siete seguros, tres de conflicto y uno de sonido solo.

La nueva secuencia debe construir lado y tipo de evento juntos:

- los tres conflictos y el sonido solo solo se colocan donde el lado cambia;
- los siete seguros pueden ser cambio de lado o repeticion del mismo lado;
- el primer evento de la sesion sigue siendo seguro.

Asi se conserva la regla conductual del programa viejo y, al mismo tiempo, se
obtiene el conteo experimental exacto de `7 seguro + 3 conflicto + 1 sonido
solo` por bloque.
