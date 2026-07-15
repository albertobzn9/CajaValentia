# V4: Reescritura Moderna

## Estado

V4 sera una reescritura total de CajaValentia en otro lenguaje y otro stack.
No es una migracion de MATLAB ni una extension de las GUIs GUIDE. Esta fuera del
alcance del trabajo actual sobre el runtime R2011a y la caja simulada.

Este es el unico documento de planeacion arquitectonica para V4. Los demas
documentos pueden enlazarlo, pero no deben duplicar ni fijar decisiones de
stack para V4.

## Requisitos Ya Fijados

- Plataforma: Windows solamente.
- Aplicacion nativa de escritorio, con inicio rapido.
- Debe funcionar de forma confiable en la PC de laboratorio con 8 GB de RAM.
- Debe tener una ruta de compatibilidad verificable con la tarjeta National
  Instruments y el equipo existente del laboratorio.
- Debe preservar y validar por separado la logica conductual, los tiempos y
  los datos antes de sustituir MATLAB R2011a en produccion.

## Direccion De Stack

La direccion actual es .NET con WPF o una alternativa equivalente, nativa para
Windows. Avalonia no forma parte de la direccion actual de V4.

La eleccion final de framework, version de .NET, arquitectura de procesos,
audio, integracion con National Instruments y formato de datos queda diferida.
No se debe convertir esta nota en una implementacion ni en un compromiso de
stack sin una evaluacion especifica de esos requisitos.

## Limite Con El Trabajo Actual

`main` y MATLAB R2011a siguen siendo el runtime operativo. El simulador de
caja se construira para probar y entender ese runtime; no es el inicio de V4.
Toda sustitucion de hardware o uso con animales requerira validacion fisica de
equivalencia en una etapa posterior.
