# Contador De Cruces Validos En ValentiaE

## Decision

En `ValentiaE`, el contador visible y el final automatico usan solo
`cmc_es_cruce_valido`. El objetivo escrito por el operador representa cruces
validos, no filas de resultados.

Un cruce valido exige cambio de lado, zona inicial lateral confirmada y un
desplazamiento de al menos un segundo. No cuentan no-cruces, repeticiones del
mismo lado, inicios desde la zona central ni eventos de sonido solo.

## Alcance Limitado

- Se conserva el formato actual de nueve columnas.
- Se conserva la semantica actual de recompensas y palanqueo.
- La secuencia se prepara con al menos 1000 eventos para no agotarse antes de
  cumplir el objetivo cuando hay no-cruces.
- No se recupera la regla experimental V2.4 que contaba algunos no-cruces.

## Limitacion Conservada

El cruce se detecta antes de la espera de palanca, pero el contador visible y
el final se actualizan al cerrar el evento. Si la rata llega y no palanquea,
la espera sin limite permanece; el operador debe usar `Detener ahora`.

## Validacion Requerida

1. Ejecutar `cmc_prueba_sin_hardware_completa`.
2. En una prueba fisica corta, comprobar que 29 cruces no terminan y el cruce
   valido numero 30 cierra la secuencia despues de finalizar su evento.
3. Comprobar que un no-cruce no aumenta el contador y que el guardado produce
   el CSV principal y CSV de palanqueos esperados.
