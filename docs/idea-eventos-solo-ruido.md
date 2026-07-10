# Idea: Eventos de Solo Ruido

## Pregunta Experimental

Estos eventos permiten separar el efecto de la señal aversiva del efecto de la
señal de comida. La pregunta es: cuando la rata escucha el ruido asociado al
riesgo, pero no hay luz de comida ni posibilidad de recompensa, ¿qué hace?

Esto es especialmente útil para interpretar conducta y actividad
electrofisiológica sin confundir amenaza, expectativa de comida y decisión de
cruzar.

## Qué Es Un Evento De Solo Ruido

Es un evento con ruido aversivo, LED marcador y parrilla activa, pero sin:

- luz de comida;
- pellet o recompensa;
- final anticipado si la rata cruza o presiona una palanca.

Por eso se llama “solo ruido” en el sentido experimental: no presenta la señal
ni la consecuencia de comida. Conserva los componentes aversivos necesarios
para comparar con un ensayo de conflicto.

## Dónde Aparece

### Discriminación

Solo aparece cuando el riesgo es mayor que cero. Cada bloque contiene diez
eventos con comida y un evento de solo ruido. El evento de riesgo y el de solo
ruido solo pueden aparecer cuando cambia el lado de la rata, porque de otro modo
no existiría una decisión de cruce.

Con riesgo `0.3`, por ejemplo, cada bloque tiene siete seguros, tres de riesgo
con comida y uno de solo ruido. El evento de solo ruido dura 180 segundos.

### Cruces Peligrosos

Los cruces peligrosos normales continúan igual. Los eventos de solo ruido se
programan cerca de los minutos 9, 18 y 27 de la sesión conductual. Duran lo que
el operador indique para el ensayo de riesgo de ese día. Nunca interrumpen un
ensayo ni un ITI: esperan al siguiente punto seguro entre ensayos.

## Cómo Queda Registrado

En los resultados, `TipoEvento = 2` identifica un evento de solo ruido.

- `0`: ensayo seguro.
- `1`: ensayo de riesgo/conflicto con comida.
- `2`: evento de solo ruido, sin comida.

## Límite Importante

No debe aparecer en cruces seguros. Si el riesgo es `0`, el programa conserva
la tarea normal y no agrega eventos de solo ruido.

Para detalles de implementación y pruebas, ver
[`sound-only-controls.md`](sound-only-controls.md).
