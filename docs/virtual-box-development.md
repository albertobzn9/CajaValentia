# Caja Virtual: Desarrollo Sin Hardware

## Decision Actual

El equipo desarrollara y probara una caja conductual virtual en la MacBook Neo,
sin Windows, sin maquina virtual y sin la caja fisica. El entorno de la Mac es
MATLAB R2026a; el runtime que opera la caja real sigue siendo MATLAB R2011a en
la PC de laboratorio.

Esto no cambia V4: la reescritura total futura seguira siendo una linea
independiente para Windows. Ver [la planeacion de V4](modern-rewrite-blueprint.md).

## Objetivo

Poder hacer pruebas basicas de las tareas sin trasladarse al laboratorio ni
conectar la caja. La caja virtual mostrara y recibira los elementos que un
operador necesita para entender una sesion:

- Sensores de posicion izquierda, centro y derecha.
- Palancas izquierda y derecha.
- Luces de la caja, pellet y parrilla como indicadores visuales.
- Sonido izquierdo, derecho o ambos como indicador visual; al inicio no se
  reproducira por las bocinas de la Mac.
- Un registro de lo que la tarea solicito y de lo que se simulo.

La caja virtual no reproduce a una rata ni pretende certificar el timing fisico
de luces, pellet, parrilla o audio. Sirve para probar reglas, flujo de la tarea,
guardado y reacciones basicas de la interfaz antes de una prueba fisica.

## Compatibilidad Entre Las Dos Computadoras

La compatibilidad sera del codigo nuevo, no de los controladores de hardware:

| Equipo | Version de MATLAB | Modo permitido |
| --- | --- | --- |
| MacBook Neo | R2026a | Caja virtual solamente. |
| PC de laboratorio | R2011a | Caja virtual o caja real, elegido de forma explicita. |

El nuevo codigo se escribira con funciones y controles que ya existian en
R2011a: archivos `.m`, estructuras simples y ventanas clasicas de MATLAB. No
usara App Designer, `uifigure` ni funciones modernas que R2011a no conozca.

Las GUIs GUIDE existentes permanecen como estan. No se abriran ni guardaran
sus archivos `.fig` desde R2026a, porque hacerlo puede impedir abrirlos de
vuelta en R2011a. La ventana de la caja virtual se construira por codigo con
los controles clasicos de la epoca de GUIDE; se vera y operara como una ventana
simple de MATLAB, aunque no se edite con el diseno grafico GUIDE en la Mac.

## Separacion Segura De Modos

Cada inicio tendra un modo declarado antes de abrir una tarea:

- `simulado`: lee botones de la caja virtual y solo cambia indicadores y el
  registro de simulacion.
- `real`: usa la tarjeta, sensores, audio y salidas fisicas de la caja. Solo
  podra usarse en la PC de laboratorio, con una persona capacitada presente.

No habra cambio automatico entre modos. Si falta una configuracion valida, la
tarea debe detenerse sin abrir `Dev2`, sin encender una salida y sin activar
audio fisico.

## Alcance Tecnico Pequeno

No se reescribiran las tareas. Se aislara el limite donde el programa pide o
lee una accion de la caja: iniciar la tarjeta, leer sensores y palancas,
escribir luces/pellet/parrilla y registrar el sonido solicitado. En modo
simulado esas acciones van a la caja virtual; en modo real conservan el camino
actual de R2011a.

Las reglas conductuales de ValentiaE, Cruces Peligrosos, Moldeamiento,
Luz-Comida y Condicionamiento no cambian como parte de este trabajo.

## Orden De Pruebas

1. Probar el nucleo virtual sin GUI: inicio seguro, sensores, palancas,
   salidas y registro de sonido.
2. Abrir la ventana de caja virtual en la Mac y confirmar manualmente cada
   indicador, sin hardware conectado.
3. Ejecutar la misma prueba en la PC de laboratorio con modo `simulado`, sin
   abrir la tarjeta.
4. Conectar una tarea por vez a la caja virtual y repetir sus escenarios
   basicos.
5. Solo despues disenar una prueba corta y supervisada de modo `real`.

Cada paso necesita un resultado esperado y observado. Una prueba virtual no
reemplaza la prueba fisica, pero evita que los fallos de logica basicos lleguen
a la caja.

## Por Que No Usar R2015a O Una Maquina Virtual Ahora

R2015a y R2011a fueron creados para computadoras Intel anteriores a Apple
Silicon. En la MacBook Neo requeririan emulacion y dependencias antiguas; eso
agrega otra fuente de fallos y no resuelve la necesidad de una interfaz visual.
Una maquina virtual Linux sin interfaz grafica tampoco permite operar palancas,
sensores y luces virtuales de manera util.

MATLAB R2026a en la Mac se usara solo como host nativo de la simulacion. No
controlara la tarjeta National Instruments ni sustituira el runtime R2011a de
la caja real. Ver [migracion de MATLAB](migration-matlab-2026.md).

## Nota: Ventajas De Un Entorno Windows

Un equipo Windows separado tambien podria ser un entorno de desarrollo valido.
Sus ventajas serian ejecutar MATLAB R2011a de forma nativa, editar visualmente
las GUIs GUIDE y parecerse mas a la PC del laboratorio. Con los drivers y la
tarjeta adecuados tambien permitiria pruebas de compatibilidad de NI mas
cercanas a la caja real. Codex podria trabajar en ese equipo sobre una copia
del repositorio sin que este conectado a la caja.

No es la opcion actual porque volveria a depender de otro equipo, acercaria el
desarrollo al hardware real y no mejora la portabilidad de las pruebas basicas.
Si se adopta despues, debe ser una PC de desarrollo separada de la caja de
produccion y seguir usando primero el modo `simulado`.
