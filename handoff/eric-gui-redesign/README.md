# Handoff: Rediseño GUIDE R2011a

Inicio previsto: 20-jul-2026. Duracion: tres semanas.

> Antes de editar la GUI, leer [Recuperacion e integracion](RECOVERY_AND_INTEGRATION.md).
> Las funciones perdidas se investigan e integran una por una desde `main`;
> esta carpeta no autoriza fusionar toda una rama experimental.

## Objetivo

Crear una interfaz GUIDE nueva para `ValentiaE`, `ValentiaE2` y `EntrenaE`, sin
reescribir la logica conductual ni la capa de hardware. La unica base de codigo
para este trabajo es `runtime-v1-clean/`, copia exacta de `v1.0.0`.

Leer primero:

1. [Requisitos](REQUIREMENTS.md).
2. [Contrato de backends](BACKEND_CONTRACT.md).
3. `../../docs/architecture/matlab-runtime-overview.md`.
4. `../../AGENTS.md`.

## Entregable En Tres Semanas

- Tres GUIs limpias, basadas en `mockups/gui-redesign-wireframes-v1.png`.
- Preparar una capa de seleccion para el futuro toggle `V1 limpio / Actual`;
  por ahora, solo `V1 limpio` tiene backend entregado.
- El futuro selector se bloqueara mientras haya sesion activa y nunca podra
  mezclar rutas de ambos arboles.
- Pruebas sin hardware, seguido por una prueba supervisada corta con la caja.

## Fuera De Alcance Inicial

- Reescribir tarjeta NI, audio, logica de ensayos o formato CSV.
- Cambiar reglas conductuales por los apuntes de wishlist sin aprobacion.
- Migrar fuera de MATLAB R2011a/GUIDE.
- Usar `../../legacy/` (V0) o `../../matlab/` (V2/3) como fuente de este
  rediseño inicial.

Los dos bocetos originales estan en `mockups/`. La lamina generada es una guia
de distribucion, no un diseno visual final obligatorio.
