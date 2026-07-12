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

Los objetivos son los min 9, 18 y 27 del bloque conductual. El planificador
conserva el ITI aleatorio de 60--180 s, pero limita solo el ITI final necesario
para que un control pendiente inicie antes de 30 min. Si iniciar un CP normal
podria dejarlo fuera de ese limite, el control toma prioridad. Un ensayo ya
iniciado puede terminar despues de los 30 min; enseguida inicia habituacion
final. La novena columna de `Resultados` distingue CP normal (`1`) de sonido
solo (`2`).

`OA_SecuenciaEnsayos4` guarda lado de origen. Los altavoces y LED del control
deben usar el lado opuesto: `cmc_lado_objetivo_cp` hace esa conversion y evita
la inversion historica del sonido.

Un ensayo CP no puede esperar una palanqueada indefinidamente. Desde el inicio
del ensayo, el limite total es `duracion maxima + 10 s` (por ejemplo, 30 s se
cierran a 40 s). Si la rata cruzo pero no palanqueo antes del limite, se guarda
el cruce, no se entrega pellet y el programa continua.

## Consecuencia

La hora es aproximada por diseno: preserva el ITI aleatorio y evita cortar un
ensayo. El planificador y sus cuatro duraciones fueron simulados sin hardware;
falta validar MATLAB R2011a y la caja fisica antes de uso experimental.
