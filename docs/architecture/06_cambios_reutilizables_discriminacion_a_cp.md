# Estado Operativo: Discriminacion Y Transferencia A CP

> Documento historico de una rama experimental retirada. No aplicar sus
> cambios de conteo, CSV o limite de mismo lado directamente a `main`.
> Ver [comportamiento actual](../current-runtime-behavior-and-known-limitations.md)
> antes de retomar CP.

Este es el resumen vigente. Para la historia de pruebas y despliegues, leer la
[bitacora de laboratorio](../bitacora-lab-2026-07-12-valentiae.md).

## Version Estable

- Codigo estable: rama `main`.
- Etiqueta: `v2.0.0-rc.4-discriminacion-validada`.
- Programa validado: `OA_ValentiaCuatroE` (Discriminacion).
- Copia usada en la caja: `C:\Users\Alberto\Desktop\CajaValentia_R2011a_CrucesSensor`.
- `OA_ValentiaCuatroE2` (Cruces Peligrosos) sigue fuera de `main` para trabajo
  y prueba separados.

## Cambios De Discriminacion

| Modulo o cambio | Archivos principales | Estado actual | Prueba pendiente exacta |
|---|---|---|---|
| Arranque seguro, sin pellet al abrir | `Valentia/OA_ValentiaInicio.m` | Probado con la caja. | Ninguna para esta version. |
| Ruido blanco 15 kHz y salida estereo | `cmc_frecuencia_ruido_predeterminada.m`, `OA_Sonidos.m` | Probado fisicamente por ambos lados. | Ninguna para esta version. |
| Solo sonido: 180 s, sin luz/pellet | `OA_ValentiaCuatroE.m`, `Valentia/OA_MonitoreaSonidoSolo.m`, `Valentia/OA_SecuenciaDiscriminacionSonidoSolo.m` | Probado: tipo `2`, 180 s, contador sin cambio. | Ninguna para Discriminacion. |
| Sonido solo solo con riesgo mayor que 0 y casilla 1:10 | `OA_SecuenciaDiscriminacionSonidoSolo.m`, `OA_ValentiaCuatroE.m` | Probado en secuencia y caja. | Ninguna para Discriminacion. |
| Contador `Ensayos de cruce` y cierre automatico | `cmc_cuenta_ensayo_cruce.m`, `cmc_es_cruce_valido.m`, `OA_ValentiaCuatroE.m` | Probado: cruce lateral y no-cruce lateral cuentan; inicio sin laser, centro y mismo lado no. | Ninguna para esta regla. |
| Limite de no-cruce y mismo lado | `cmc_limite_duracion_sin_cruce.m`, `OA_ValentiaCuatroE.m` | Pasa prueba sin hardware; se acepta para esta version. | Auditoria futura: con duracion configurada en 180 s, medir que cierre a 60 s. |
| Tabla y CSV de 10 columnas | `cmc_configurar_tabla_resultados.m`, `cmc_mostrar_tabla_resultados.m`, `cmc_escribir_csv_resultados.m` | Probado en R2011a. | Ninguna; revisar visualmente solo si se cambia la GUI. |
| Columna `ensayo_cruce` | `OA_ValentiaCuatroE.m`, `cmc_cuenta_ensayo_cruce.m` | Probado: `1` cuenta, `0` no cuenta, `NA` es solo sonido. | Ninguna para esta version. |
| CSV de palanqueos por fase | `cmc_registrar_palanqueos.m`, `cmc_escribir_csv_palanqueos.m` | Probado en habituacion, ITI, ensayo y final. | Prueba dedicada: una presion por lado en habituacion inicial y final, confirmar reloj y contadores visibles. |
| Habituacion inicial/final y guardado automatico | `cmc_actualizar_reloj_fase.m`, `cmc_solicitar_guardado_final.m`, `OA_ValentiaCuatroE.m` | Flujo y CSV probados; reloj pasa suite sin hardware. | Configurar 30 s de habituacion y confirmar visualmente tiempo, contadores y dialogo de guardado final. |
| Aviso LED final opcional | `cmc_iniciar_aviso_led_final.m`, `cmc_detener_aviso_led_final.m` | Prueba sin hardware aprobada. | Activar casilla y confirmar LED: 100 ms cada 2 s mientras se muestra Guardar resultados. |

## Formato De Resultados

`nombre.csv` tiene una fila por evento terminado:

```text
ensayo,lado,estimulo,latencia_s,tiempo_absoluto_s,palancas_izq,palancas_der,desplazamiento_s,tipo_evento,ensayo_cruce
```

Reglas importantes:

- `lado=-2`: la rata no llego al lado objetivo.
- `ensayo_cruce=1`: el evento avanzo el objetivo, incluso si fue un no-cruce
  lateral valido.
- `ensayo_cruce=0`: mismo lado, inicio desde centro o sin deteccion corporal.
- `ensayo_cruce=NA`: solo sonido; nunca avanza el contador.

`nombre_palanqueos.csv` guarda cada presion con fase, ensayo, tipo y lado.

## Cruces Peligrosos: Fuera De Main

Rama: `feature/cp-time-aware-sound-only`.

Antes de integrarla, hacer una prueba fisica de CP que confirme, en este orden:

1. Arranque sin pellet y un pellet por palanqueo en ambos lados.
2. Sonido solo cerca de los minutos 9, 18 y 27, sin luz ni pellet.
3. Audio en el lado objetivo correcto.
4. Limite de respuesta: duracion del ensayo + 10 s cuando cruza sin palanquear.
5. Habituacion final, ambos CSV y `Detener tras ensayo`.

No copiar automaticamente la regla de cierre de Discriminacion: CP termina por
tiempo de sesion, no por el contador de ensayos de cruce.

## Regla De Trabajo

Todo cambio nuevo: prueba sin hardware, prueba corta con la caja, CSV revisado,
bitacora actualizada y despues commit. Mantener el lanzador sin administrador
fuera de uso hasta una prueba propia; el lanzador diario sigue siendo el de
`CajaValentia_R2011a_CrucesSensor`.
