# Start Here: Handoff Para Un Agente Nuevo

## Mision

Este repositorio preserva y opera la Caja CMC/Valentia: tareas conductuales
para ratas controladas por MATLAB R2011a, una tarjeta NI antigua y audio
Windows. El objetivo inmediato no es reescribirla: es mantener un runtime
estable, documentar sus limites y hacer cambios pequenos, trazables y probados
con la caja.

La reescritura moderna vendra despues de estabilizar requisitos conductuales,
hardware y datos. No asumir que MATLAB moderno, .NET u otro runtime puede
sustituir la caja actual sin validacion fisica de equivalencia.

## Fuente De Verdad

- **Repo canonico:** este GitHub, rama `main`.
- **Archivo historico:** `legacy/`; nunca editarlo ni limpiarlo.
- **Copia ejecutable:** `matlab/`; es el paquete R2011a.
- **Drive:** archivo y contexto adicional, no fuente activa de codigo.
- **Resultados de sesiones y datos de animales:** nunca se suben a Git.

Al iniciar, ejecutar `git status --short`, confirmar rama y leer en orden los
documentos de abajo. No confiar en una memoria de chat ni en rutas antiguas de
USB/Escritorio sin verificarlas en la PC de laboratorio.

## Lectura Obligatoria

1. [`../AGENTS.md`](../AGENTS.md): reglas mecanicas y de seguridad.
2. [`../README.md`](../README.md): estado y version actual.
3. [`current-runtime-behavior-and-known-limitations.md`](current-runtime-behavior-and-known-limitations.md): comportamiento real de `main`.
4. [`behavioral-protocol.md`](behavioral-protocol.md): tarea experimental.
5. [`validation.md`](validation.md): evidencia y pruebas pendientes.
6. [`repository-branches.md`](repository-branches.md): ramas historicas o pendientes.

Lectura adicional segun el cambio:

- Hardware, sensores, parrilla, pellet o audio:
  [`hardware-io.md`](hardware-io.md).
- Discriminacion / ValentiaE: `matlab/OA_ValentiaCuatroE.m` y
  `matlab/Valentia/OA_SecuenciaDiscriminacionSonidoSolo.m`.
- Cruces Peligrosos / ValentiaE2: `matlab/OA_ValentiaCuatroE2.m` y
  `matlab/Valentia/OA_EjecutaSonidoSoloCP.m`.
- Migracion: [`migration-matlab-2026.md`](migration-matlab-2026.md) y
  [`decisions/`](decisions/).
- Caja virtual: [`virtual-box-development.md`](virtual-box-development.md).
- Rediseño GUIDE de Eric:
  [`../handoff/eric-gui-redesign/README.md`](../handoff/eric-gui-redesign/README.md).

## Estado Real: 15-jul-2026

`main` es la **Base R2011a Restaurada**. Recupera una base funcional previa a
los ultimos cambios experimentales y conserva solo:

- reloj de habituacion inicial/final en `ValentiaE`;
- aviso LED final opcional durante el dialogo de guardado.

La linea posterior de conteo, cierres, CSV y limites de mismo lado se retiro
por fallas. No reintroducirla por copia y pega. Ver
[`decisions/2026-07-15-restauracion-base-valentiae.md`](decisions/2026-07-15-restauracion-base-valentiae.md).

Limites clave del codigo actual:

- En `ValentiaE` y CP, la duracion maxima solo limita hasta detectar llegada;
  despues puede esperar palanca sin limite.
- En CP, "cruzo pero no palanqueo" deja activo el ensayo hasta palanqueo o
  **Detener ahora**.
- En `ValentiaE`, `Ensayos terminados` cuenta filas, incluidos no-cruces y
  sonido solo; no es contador de cruces validos.
- El evento "sonido solo" activa ruido, LED marcador y parrilla; no luz de
  comida ni pellet.
- La salida actual es `.mat` con nueve columnas y un CSV separado de
  palanqueos. El CSV principal de diez columnas y `ensayo_cruce` son historia.

La explicacion completa y las acciones operativas estan en
[`current-runtime-behavior-and-known-limitations.md`](current-runtime-behavior-and-known-limitations.md).

## Mapa De Codigo

```text
matlab/abrir.m -> abrir1.m -> menu de cinco tareas
                           -> OA_ValentiaCuatroE.m   (ValentiaE)
                           -> OA_ValentiaCuatroE2.m  (ValentiaE2 / CP)
                           -> OA_ValentiaEntrenaPalancasCPE.m
                           -> Valentia/OA_ValentiaEntrenaPalancasCP.m
                           -> OA_Condiciona_Aleatorio.m
```

Rutas requeridas por MATLAB:

- `matlab/`
- `matlab/Valentia/`
- `matlab/Valentia/valentia/`

`cmc_setup_paths.m` las agrega. No aplanar ni renombrar estas carpetas: el
codigo y los `.mat` de estado dependen de su estructura.

## Hardware Y Seguridad

- `OA_ValentiaInicio.m` abre la tarjeta fija `Dev2`.
- El audio usa `winsound` a 20 kHz.
- Nunca abrir GUI ni activar hardware por SSH sin una persona entrenada frente
  a la caja.
- No adivinar IP, usuario Windows, letra de unidad o permisos de administrador:
  confirmar el estado actual de la PC antes de operar.
- Todo cambio de luces, pellet, parrilla, audio, palancas, sensores o timing
  requiere prueba sin hardware y despues una prueba corta supervisada.

## Pruebas

La prueba logica principal es:

```matlab
cmc_prueba_sin_hardware_completa
```

Se corre desde `matlab/` con una version compatible de MATLAB. No valida NI,
audio, sensores ni dispensadores reales. Una prueba fisica solo cuenta cuando
se documentan version MATLAB, equipo, parametros, resultado esperado y
resultado observado.

## Ramas Y Versiones

| Referencia | Uso |
|---|---|
| `main` | Unica base actual para trabajo nuevo. |
| `v0.1.0` | Programa original archivado, solo auditoria. |
| `v1.0.0` | Base limpia R2011a entregada a Eric para GUI. |
| `v2.0.0-rc.4-discriminacion-validada` | Hito historico de la linea retirada; no es `main`. |
| `feature/discriminacion-cierre-habituacion` | Archivo del experimento retirado; no integrar. |
| `feature/cp-time-aware-sound-only` | Investigacion CP; no integrar sin comparar y probar. |
| `migration/r2022a-r2026a-ni-usb6501` | Investigacion de migracion, no runtime R2011a. |

Antes de usar una rama:

```bash
git fetch --prune origin
git status --short
git log --oneline --decorate -12
git diff --stat main...nombre-de-rama
```

Nota de respaldo: al 15-jul-2026, la rama local
`feature/discriminacion-cierre-habituacion` esta un commit adelante de su
equivalente en `origin`. Es material archivado, no debe empujarse ni borrarse
sin decision explicita.

## Forma De Trabajar

1. Describir primero el cambio en terminos conductuales.
2. Identificar modulos y dependencias.
3. Crear una rama desde `main` con un solo objetivo.
4. Ejecutar pruebas de logica sin hardware.
5. Diseñar una prueba fisica corta con criterio de exito.
6. Probar con persona presente, documentar resultado y actualizar docs.
7. Solo entonces proponer merge a `main`.

Una etiqueta Git no equivale a una garantia experimental. Una excepcion nueva
debe documentarse el mismo dia en `current-runtime-behavior-and-known-limitations.md`
o `validation.md`.

## Pendientes Reales

1. Probar `ValentiaE` actual: reloj, LED final, guardado `.mat` mas CSV de
   palanqueos y **Detener ahora**.
2. Probar CP actual: ITI, sonido solo, guardado manual y "cruzo pero no
   palanqueo".
3. Verificar botones de detener del lado derecho en Moldeamiento y Luz-Comida.
4. Mantener migracion/rewrite como linea separada hasta validar hardware
   equivalente.

## Prompt De Inicio Sugerido

```text
Lee AGENTS.md y docs/START_HERE_NEW_AGENT.md completos. Resume el estado de
main, los limites conocidos y los modulos implicados en mi solicitud. No edites
ni abras hardware hasta confirmar alcance y proponer la prueba correspondiente.
```
