# Hoja De Ruta: Julio-Diciembre 2026

## Proposito

Esta hoja de ruta conserva el orden de trabajo acordado para CajaValentia.
No sustituye el estado real de main, las reglas de seguridad ni la
planeacion de V4; indica que proceso toca en cada periodo y que resultado debe
dejar antes de avanzar.

## Bases De Codigo

Los nombres B1, B2 y B3 son etiquetas operativas para esta hoja de ruta. Los
nombres y referencias Git oficiales permanecen en [el mapa de versiones](version-map.md).

| Etiqueta | Referencia | Uso |
| --- | --- | --- |
| B1 | legacy/ / V0 | Archivo original. Solo auditoria; no se edita ni se opera. |
| B2 | v1.0.0 / handoff/eric-gui-redesign/runtime-v1-clean/ | Base limpia R2011a entregada a Eric para el rediseño de interfaz. |
| B3 | main | Base R2011a Restaurada, operativa. Conserva reloj de habituacion y aviso LED final. |

B3 es la version actual de main. B2 no es una version anterior por error:
es la base congelada que Eric necesita para cambiar la interfaz sin mezclar sus
tres semanas de trabajo con cambios conductuales o de hardware en B3.

## Corto Plazo: Eric Y La Interfaz

**Periodo: 15-jul-2026 a fin de agosto de 2026.**

Eric tendra tres semanas de trabajo activo para rediseñar las interfaces de
ValentiaE, ValentiaE2 y EntrenaE sobre B2. Su papel es principalmente de
frontend: claridad visual, controles y flujo de operador. Puede corregir
detalles de backend que sean necesarios para que esas interfaces funcionen,
pero no debe cambiar reglas conductuales, tarjeta NI, audio ni formato de
datos sin una decision separada.

La fecha objetivo de cierre es el final de agosto; el tiempo adicional despues
de las tres semanas sirve para revision, pruebas sin hardware y preparacion de
la integracion. El contrato de trabajo de Eric esta en
[handoff/eric-gui-redesign](../handoff/eric-gui-redesign/README.md).

**Criterio para cerrar esta fase:** las tres GUIs se entienden y ejecutan sobre
B2 sin hardware; sus cambios quedan separados y listos para comparar e
integrar contra B3 de forma controlada.

## Mediano Plazo: Entender El Programa Modulo Por Modulo

**Periodo: septiembre y octubre de 2026.**

El objetivo no es cambiar mas logica a la vez. Es construir una explicacion
clara del programa para el equipo: que hace cada modulo, de que entradas
depende, que salidas solicita, que archivos produce, que riesgos operativos
tiene y como se prueba sin hardware.

El resultado esperado es un mapa legible de B3, empezando por abrir1 y las
cinco tareas del menu, y siguiendo sus modulos compartidos de sensores,
palancas, luces, pellet, parrilla, audio, secuencias y guardado. Cada cambio
posterior debera ser pequeno, aislado y acompañado por una prueba concreta.

La [caja virtual](virtual-box-development.md) es una herramienta de esta fase:
permitira probar flujos basicos sin depender de la caja fisica. No reescribe el
programa ni sustituye una prueba supervisada de la caja real.

**Criterio para cerrar esta fase:** existe una ficha por modulo relevante, se
conocen sus dependencias y limites, y cada comportamiento pendiente tiene una
prueba propuesta antes de modificarlo.

## Largo Plazo: V4

**Periodo de inicio: noviembre y diciembre de 2026.**

Despues de estabilizar B3 y entender sus modulos, comenzara la reescritura
total V4 en otro lenguaje y stack. Es una aplicacion futura separada de MATLAB,
no una migracion incremental de GUIDE.

El trabajo de noviembre-diciembre inicia V4: confirmar requisitos, elegir el
stack Windows nativo y construir el primer corte verificable. No equivale a
autorizar que V4 sustituya la caja en produccion dentro de ese mismo periodo.
La compatibilidad con NI, el equipo de laboratorio, los tiempos conductuales y
los datos necesita validacion propia antes de cualquier uso con animales.

La unica fuente de planeacion tecnica de V4 es
[modern-rewrite-blueprint.md](modern-rewrite-blueprint.md).

## Regla De Transicion

No se avanza de fase porque exista codigo en una rama. Se avanza cuando el
resultado de la fase anterior se entiende, se prueba en el alcance que le
corresponde y queda documentado. B1 se conserva; B2 permite el trabajo de
Eric; B3 mantiene la operacion actual; V4 empieza solo despues de comprender y
estabilizar B3.
