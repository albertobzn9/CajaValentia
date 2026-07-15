# Contrato Temporal Para La Reescritura

## Contexto

En la prueba física del 11-jul-2016, el flujo de Discriminacion dejó cerca de
`6.77 s` entre el registro MATLAB de una respuesta y el inicio MATLAB del
siguiente evento. No existe un `pause(6.77)` intencional: el tiempo surge de
apagados, lecturas/escrituras de la tarjeta y pausas dispersas en MATLAB.

Ese intervalo es conductualmente útil. Da a la rata tiempo entre ensayos y
explica por qué puede quedar en el centro antes del siguiente estímulo. Pero no
debe depender de que una computadora vieja o una tarjeta lenta lo produzcan por
casualidad.

## Decisión

La futura aplicacion Windows de V4, definida en el
[`modern-rewrite-blueprint.md`](../modern-rewrite-blueprint.md), debe modelar
el ITI como una fase explícita de la tarea. La interfaz puede
mostrarla, pero la lógica debe vivir fuera de la GUI y fuera del adaptador de
hardware.

## Requisitos

1. Configurar la duración o política del ITI de forma explícita por protocolo.
   No ocultarla en pausas de luces, audio o tarjeta.
2. Registrar timestamps monotónicos para: estímulo solicitado, estímulo físico
   confirmado si el hardware lo permite, respuesta, apagado e inicio/fin de
   ITI.
3. Mantener tiempo suficiente sin estímulos entre ensayos. El valor observado
   de `6.75-6.79 s` es una referencia de compatibilidad para Discriminacion,
   no una constante universal ni una decisión final de protocolo.
4. La lógica de cruces debe aceptar que la rata pueda entrar al centro durante
   ITI; no debe inferir su posición inicial solo del ensayo anterior.
5. El reloj conductual debe seguir siendo correcto aunque la UI se congele o
   una operación de la tarjeta tarde más de lo esperado. Las demoras de
   hardware se registran como diagnóstico, no definen la tarea.

## Verificación De Migración

Antes de usar la nueva aplicación con animales, medir con video y registros de
la aplicación: ITI visual, ITI lógico, latencia de encendido de luces, audio y
parrilla. Comparar por separado contra la referencia MATLAB; no copiar
automáticamente los `6.77 s` sin validación conductual.
