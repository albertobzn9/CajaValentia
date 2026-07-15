# Que Hace `ValentiaE` Detras De La GUI

> Documento historico de una rama experimental retirada. Las secciones sobre
> `ensayo_cruce`, CSV principal y conteo de cruces no reflejan `main`.
> La especificacion operativa actual esta en
> [comportamiento actual](../current-runtime-behavior-and-known-limitations.md).

Esta guia describe la version estable en `main`. No requiere leer codigo para
entender que cambian riesgo, aleatorizacion, numero de ensayos y sonido solo.

## Secuencia Historica

`ValentiaE` genera primero 1000 lados. El maximo de repeticiones limita cuantos
eventos seguidos pueden quedar en el mismo lado. Despues marca los cambios de
lado como candidatos de riesgo; los eventos repetidos en el mismo lado siempre
son seguros.

`OA_ValentiaRiesgo` trabaja en bloques de 10 y usa `round(riesgo * 10)`. Por
eso `0.15` se comporta como 2 riesgos de cada 10 candidatos, no como 15% exacto.

| Riesgo escrito | Riesgos por bloque |
| --- | ---: |
| `0` | 0 |
| `0.10` | 1 |
| `0.15` | 2 |
| `0.20` | 2 |
| `0.30` | 3 |

La opcion visual `Secuencia aleatoria` no controla este calculo actual. La
secuencia ya es aleatoria; la casilla se conserva por continuidad operativa.

## Sonido Solo En Discriminacion

La casilla `Agregar evento sonido 1:10` esta activa por defecto. Su regla es:

- Riesgo `0`: no agrega sonido solo; cruces seguros conservan su conducta.
- Riesgo mayor que `0` y casilla activa: cada 10 eventos con comida recibe un
  evento extra tipo `2`.
- Tipo `2`: fuerza cambio de lado, dura 180 s completos, no enciende luz de
  comida, no entrega pellet y no aumenta `Ensayos de cruce`.
- Casilla apagada: usa la secuencia historica, sin tipo `2`.

Para construir esta modalidad, `OA_ValentiaCuatroE` prepara al menos 1000
eventos con comida. Con sonido solo activo, la secuencia contiene un evento
adicional por cada bloque de 10. El campo `Ensayos a realizar` no limita esa
preparacion: indica la meta de **ensayos de cruce** que debe alcanzar la sesion.

## Que Cuenta Para El Paro Automatico

El contador `Ensayos de cruce` se actualiza al terminar cada evento normal.

| Situacion | `ensayo_cruce` | Aumenta contador |
| --- | --- | --- |
| Cruce lateral valido, desplazamiento >= 1 s | `1` | Si |
| No cruza, pero inicia lateral y el objetivo cambia de lado | `1` | Si |
| Repeticion del mismo lado | `0` | No |
| Inicio desde centro o sin deteccion corporal | `0` | No |
| Tipo `2`, solo sonido | `NA` | No |

Un ensayo normal sin cruce o en el mismo lado termina en
`min(duracion configurada, 60 s)`. El limite evita que una sesion quede
indefinida cuando la rata no responde.

## Ejemplos Practicos

- Poner `300` deja tiempo para detener manualmente, pero no cambia los primeros
  eventos de una secuencia dada; la meta automatica seria 300 ensayos de cruce.
- Poner `30` usa la misma planificacion larga, pero termina al llegar a 30
  ensayos de cruce.
- Riesgo `0.3` con sonido solo activo construye, por bloque, siete seguros,
  tres de comida+risk y uno solo sonido; el orden varia entre bloques.

## Archivos A Revisar

- GUI y bucle de sesion: `OA_ValentiaCuatroE.m`.
- Lados historicos: `Valentia/OA_Secuencia.m`.
- Riesgo historico: `Valentia/OA_SecuenciaEnsayos3.m` y
  `Valentia/OA_ValentiaRiesgo.m`.
- Modalidad nueva: `Valentia/OA_SecuenciaDiscriminacionSonidoSolo.m`.
- Conteo y CSV: `cmc_cuenta_ensayo_cruce.m` y
  `cmc_escribir_csv_resultados.m`.
