# CajaValentia

Software de control para la caja conductual CMC/Valentia. Conserva el programa
MATLAB R2011a original, una base depurada y las mejoras validadas para las
tareas de Discriminacion y Cruces Peligrosos.

> Este es software de laboratorio que controla estimulos, recompensas y
> registro conductual. No se debe operar hardware sin una persona entrenada
> presente frente a la caja.

## Proposito

- Operar tareas conductuales de la caja Valentia.
- Preservar una historia auditable desde el programa original hasta las
  mejoras actuales.
- Permitir cambios revisables sin mezclar datos de animales ni archivos de
  sesion con el codigo.

`main` contiene la version estable de Discriminacion (`ValentiaE`), validada
con MATLAB R2011a y la caja el 12-jul-2026. El codigo historico se conserva
para auditoria, no para operar.

## Estado Actual

| Referencia | Uso |
| --- | --- |
| `main` | **V2.4 - Discriminacion Validada**, fuente activa de Discriminacion. |
| `v2.0.0-rc.4-discriminacion-validada` | Foto inmutable de V2.4: sonido solo, CSV de 10 columnas y contador de ensayos de cruce. |
| `feature/cp-time-aware-sound-only` | Cruces Peligrosos en desarrollo; no esta validada ni fusionada. |
| `legacy/` | Copia original de `fsotres`, solo lectura. |

La historia y los nombres oficiales viven en [docs/version-map.md](docs/version-map.md).
V0 es el original; V1 es la base limpia R2011a; V2.4 es la version estable
actual. Ninguna de las versiones antiguas es una instruccion de uso diario.

## Estructura

| Ruta | Contenido |
| --- | --- |
| `matlab/` | Paquete ejecutable actual para MATLAB R2011a. |
| `legacy/` | Archivo original V0, solo lectura. |
| `docs/` | Manuales, decisiones, arquitectura y bitacoras de validacion. |
| `tests/` | Pruebas de logica sin hardware. |
| `handoff/` | Paquetes de trabajo acotados para colaboradores. |

## Colaborar

1. Lee [AGENTS.md](AGENTS.md) y la documentacion relevante antes de editar.
2. Crea una rama; no edites `main` ni una etiqueta de version directamente.
3. Describe primero el cambio conductual y ejecuta las pruebas sin hardware.
4. Para cambios que toquen la caja, documenta version de MATLAB, equipo y
   resultado de la prueba fisica.

La guia completa esta en [CONTRIBUTING.md](CONTRIBUTING.md). El paquete para
el rediseño GUIDE esta en [handoff/eric-gui-redesign](handoff/eric-gui-redesign/README.md).

## Acceso Y Licencia

El acceso al repositorio se concede solo a colaboradores del proyecto. Aun no
se ha asignado una licencia de distribucion: no se asume permiso para reutilizar
o redistribuir el codigo fuera del equipo sin autorizacion explicita.

## Leer Primero

1. [Uso diario en la PC del laboratorio](matlab/README_USO_ESCRITORIO.md).
2. [Indice de documentacion](docs/README.md).
3. [Mapa de versiones](docs/version-map.md).
4. [Reglas de seguridad y edicion](AGENTS.md).
5. [Handoff para rediseño GUIDE](handoff/eric-gui-redesign/README.md).

## Seguridad

No operar hardware ni probar una version no validada sin una persona entrenada
frente a la caja. No subir a Git resultados de sesion, datos de animales ni
archivos generados. `legacy/` no se limpia ni se modifica.
