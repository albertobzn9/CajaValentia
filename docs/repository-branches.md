# Ramas, Commits Y Mantenimiento Del Repositorio

Foto del repositorio al 15-jul-2026. Este documento es la guia operativa para
decidir que rama usar, conservar, integrar o podar.

## Idea Central

- `main` es la unica fuente ejecutable actual. Todo trabajo nuevo empieza desde
  aqui y solo llega aqui despues de revision y prueba.
- Una **rama** es una linea de trabajo aislada. Un **commit** es una foto
  pequena y con mensaje de un cambio. Un **merge** incorpora una rama a otra.
- Una **etiqueta** (`tag`) marca un punto historico concreto. No se usa para
  trabajo nuevo ni se mueve.

GitHub recomienda usar ramas para aislar cambios y pull requests para revisar
e integrar trabajo. Tambien recomienda eliminar ramas integradas o viejas para
evitar que la lista crezca sin control. Fuentes oficiales:

- [About branches](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-branches)
- [About merge methods](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/about-merge-methods-on-github)
- [Managing branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-branches-in-your-repository)
- [About releases and tags](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases)

## Resumen Actual

| Dato | Valor |
| --- | ---: |
| Ramas locales | 5 |
| Ramas remotas reales en GitHub | 5 |
| Etiquetas historicas | 6 |
| Commits alcanzables desde `main` | 63 |
| Commits conservados por todas las referencias locales | 89 |
| Merge commits dentro de `main` | 2 |

`origin/HEAD` puede aparecer como una decima referencia remota, pero no es una
rama: solo apunta a `origin/main`.

En la tabla siguiente, **unicos** significa commits que existen solo en esa
rama y no en `main`. Una rama con `0` commits unicos ya esta contenida en
`main`.

## Mapa De Ramas

| Rama | Ultimo commit | Unicos | Estado y recomendacion |
| --- | --- | ---: | --- |
| `main` | `f63cee0` - restauracion de la base estable | 0 | **Conservar.** Rama por defecto y unica base de ejecucion. Incluye base funcional, reloj de habituacion y LED final. |
| `feature/cp-time-aware-sound-only` | `71b879c` - sonido solo temporal para CP | 7 | **Conservar, no integrar aun.** Trabajo de Cruces Peligrosos pendiente de prueba fisica. Antes de reanudarlo hay que comparar contra el `main` restaurado; no hacer merge directo. |
| `feature/discriminacion-cierre-habituacion` | `f784950` - archivo de trabajo experimental | 7 | **Archivar, no integrar.** Contiene el intento posterior que se retiro por fallas. El ultimo commit existe solo localmente; no borrar hasta extraer o descartar cada idea con calma. Luego conviene renombrarla a `archive/...` si se decide subirla. |
| `migration/r2022a-r2026a-ni-usb6501` | `2baf89d` - investigacion de migracion | 12 | **Conservar como investigacion.** Documenta la ruta MATLAB moderno/NI. No es compatible con el runtime R2011a actual y no se integra a `main`. |
| `codex/drive-archive-reference` | `25405f1` - limite futuro video/datos | 8 | **Archivar.** Mezcla decisiones historicas de Drive, audio y hardware moderno. No hacer merge ciego; sus documentos utiles se incorporan selectivamente cuando hagan falta. |

## Ramas Podadas El 15-jul-2026

Las siguientes ramas no tenian commits unicos, no tenian pull requests
abiertos y ya estaban completamente integradas en `main`. Se eliminaron local
y remotamente. Sus commits siguen en el historial de `main`; la etiqueta RC3
tambien conserva el hito de resultados.

| Rama eliminada | Ultimo commit | Motivo |
| --- | --- | --- |
| `feature/lever-event-analysis-schema` | `da4daf5` | Integrada en `main`. |
| `feature/sensor-validated-crosses` | `546c27d` | Integrada en `main`. |
| `fix/startup-and-table` | `c27f34f` | Integrada en `main`. |
| `release/v2.0.0-rc.3-resultados-9-columnas` | `db14a27` | Integrada en `main`; tag RC3 preservado. |

## Etiquetas Historicas

| Etiqueta | Uso |
| --- | --- |
| `v0.1.0` | Copia original legacy, solo auditoria. |
| `v1.0.0` | Runtime limpio autocontenido. |
| `v2.0.0-rc.1` | Primera propuesta de controles solo sonido. |
| `v2.0.0-rc.2` | Validacion de software sin hardware. |
| `v2.0.0-rc.3-resultados-9-columnas` | Hito historico de resultados. |
| `v2.0.0-rc.4-discriminacion-validada` | Hito de validacion R2011a previo a la restauracion actual. |

Una etiqueta no dice que el codigo sea la version diaria actual; solo permite
volver a inspeccionar exactamente ese momento del historial. Una release de
GitHub se construye sobre una etiqueta y sirve para empaquetar una version que
otras personas puedan descargar.

## Flujo Recomendado A Partir De Ahora

1. Partir siempre de `main` limpio.
2. Crear una rama con un solo objetivo: `feature/nombre-corto` o
   `fix/nombre-corto`.
3. Registrar en la rama: que cambio, que no cambio, y que prueba se ejecuto.
4. Abrir un pull request hacia `main` cuando la prueba este lista. Para cambios
   de hardware, la prueba fisica es obligatoria.
5. Hacer merge mediante pull request. Para CajaValentia conviene conservar el
   merge commit: deja visible que una prueba o modulo entro como unidad.
6. Despues del merge, borrar la rama de trabajo. Conservar etiquetas para hitos
   validados y ramas `archive/` solo para excepciones justificadas.

No se borrara automaticamente ninguna rama existente. Antes de podar una rama,
confirmar que no tenga pull request abierto y que `Unicos` sea `0`. GitHub
permite borrar ramas cerradas o integradas y restaurarlas desde un pull request
cerrado; aun asi, para una caja experimental siempre se revisa primero.

## Comandos De Consulta Seguros

Ejecutar desde la carpeta del repositorio. Todos son de lectura:

```bash
git branch -vv
git log --graph --oneline --decorate --all
git branch --merged main
git branch --no-merged main
git diff --stat main...feature/cp-time-aware-sound-only
git tag --list
```

Para actualizar la vista de GitHub sin cambiar codigo local:

```bash
git fetch --prune origin
```

## Decisiones Pendientes

- Decidir si `feature/discriminacion-cierre-habituacion` se conserva en GitHub
  como `archive/...` o si basta como respaldo local temporal.
- Retomar CP desde una rama nueva creada desde el `main` restaurado, usando la
  rama CP actual solo como referencia tecnica.
