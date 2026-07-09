# CP: Sonido Solo Programado Por Tiempo

## Contexto

Cruces peligrosos usa `ValentiaE2`, duraciones manuales de 30/30/60/90/120 s e
ITI aleatorio de 60-180 s. Se necesita un control de amenaza sin luz/comida para
electrofisiologia, sin interrumpir el flujo existente.

## Decision

Crear una copia aislada: `13_matlab_experimental_cruces_peligrosos_sonido_solo`.
Agenda sonido/LED + parrilla cerca de los min 9, 18 y 27 del bloque conductual.
Cada evento dura el valor manual de riesgo, no ofrece luz ni pellet y no termina
por cruce o palanca.

Si el tiempo llega durante un ensayo o ITI, el evento se ejecuta despues del ITI
y antes del siguiente ensayo CP. La novena columna de `Resultados` distingue CP
normal (`1`) de sonido solo (`2`).

## Consecuencia

La hora es aproximada por diseno: preserva el ITI aleatorio y evita cortar un
ensayo. Falta validar MATLAB R2011a y la caja fisica antes de uso experimental.
