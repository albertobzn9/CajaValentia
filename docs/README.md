# Documentacion

## Uso Y Estado Actual

La fuente ejecutable actual fue restaurada a la base funcional con reloj de
habituacion y aviso LED final. Antes de operar o modificar la caja, leer
primero [Comportamiento actual y limitaciones conocidas](current-runtime-behavior-and-known-limitations.md).
Este documento es la fuente de verdad de `main`; varios textos historicos
todavia describen la rama experimental retirada de 10 columnas.

1. [`START_HERE_NEW_AGENT.md`](START_HERE_NEW_AGENT.md): punto de entrada para retomar el proyecto sin contexto de chat.
2. [`current-runtime-behavior-and-known-limitations.md`](current-runtime-behavior-and-known-limitations.md): comportamiento real, excepciones y limites de `main`.
3. [`../matlab/README_USO_USB.md`](../matlab/README_USO_USB.md): instructivo historico de despliegue portable; no asumir USB sin confirmar la copia de la PC del laboratorio.
4. [`version-map.md`](version-map.md): que esta estable, historico o fuera de `main`.
5. [`validation.md`](validation.md): validaciones y pendientes reales.
6. [`bitacora-lab-2026-07-12-valentiae.md`](bitacora-lab-2026-07-12-valentiae.md): evidencia cronologica de una rama historica de Discriminacion.
7. [`repository-branches.md`](repository-branches.md): ramas, tags, merge y mantenimiento del repositorio.

## Entender O Cambiar El Programa

- [`behavioral-protocol.md`](behavioral-protocol.md): tarea experimental.
- [`hardware-io.md`](hardware-io.md): entradas y salidas de la caja.
- [`virtual-box-development.md`](virtual-box-development.md): plan para probar
  una caja virtual en la Mac sin depender del hardware del laboratorio.
- [`architecture/matlab-runtime-overview.md`](architecture/matlab-runtime-overview.md): mapa de modulos, conceptos GUIDE y rutas para cambiar algo.
- [`architecture/04_backend_valentiae_aleatorizacion.md`](architecture/04_backend_valentiae_aleatorizacion.md): riesgo, aleatorizacion, sonido solo y contador de cruces.
- [`architecture/05_comparacion_modulos_original_vs_limpio.md`](architecture/05_comparacion_modulos_original_vs_limpio.md): que se retuvo y que se excluyo del original.
- [`architecture/06_cambios_reutilizables_discriminacion_a_cp.md`](architecture/06_cambios_reutilizables_discriminacion_a_cp.md): cambios aplicados y checklist para Cruces Peligrosos.
- [`sound-only-controls.md`](sound-only-controls.md): contrato conductual de los eventos solo sonido.

## Futuro E Historia

- [`modern-rewrite-blueprint.md`](modern-rewrite-blueprint.md): unica fuente de
  planeacion para V4, la reescritura futura nativa para Windows.
- [`migration-matlab-2026.md`](migration-matlab-2026.md): limite y plan de migracion a MATLAB moderno.
- [`decisions/2026-07-13-obs-session-clock-and-preprocessing-handoff.md`](decisions/2026-07-13-obs-session-clock-and-preprocessing-handoff.md): contrato futuro para iniciar OBS y la sesion conductual con una identidad y reloj de sesion compartidos.
- [`decisions/`](decisions/): decisiones que deben sobrevivir cambios de contexto.
