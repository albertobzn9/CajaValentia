# Uso Diario En La PC Del Laboratorio

## Abrir La Version Validada

La copia que se usa diariamente esta en:

```text
C:\Users\Alberto\Desktop\CajaValentia_R2011a_CrucesSensor
```

1. Cerrar MATLAB por completo.
2. En el Escritorio, abrir `Abrir_CajaValentia_CrucesSensor.bat`.
3. Si Windows pide permisos, aceptar: el lanzador actual se eleva porque la
   tarjeta NI se valido asi. No se ha validado una variante sin administrador.
4. Elegir la tarea desde el menu. Para Discriminacion, seleccionar `ValentiaE`.

El lanzador ejecuta `cmc_iniciar_gui_r2011a`, que restablece las rutas de
MATLAB y confirma que las funciones vienen de esta copia del Escritorio. Asi se
evita abrir por accidente un `abrir.m` historico de otra carpeta.

## No Usar Como Flujo Diario

- No abrir `abrir.m` ni una GUI desde una carpeta generica del Escritorio.
- No reutilizar los lanzadores `RC3`; son evidencia de una etapa anterior.
- No usar R2021b/R2026a para controlar la caja. La version operativa validada
  es R2011a.

## Recuperacion Manual

Solo si el lanzador falla y una persona entrenada esta frente a la caja:

```matlab
cd('C:\Users\Alberto\Desktop\CajaValentia_R2011a_CrucesSensor')
cmc_iniciar_gui_r2011a
```

Si aparece una GUI inesperada, cerrar MATLAB completo y volver a usar el
lanzador. No intentar corregir rutas durante una sesion.

## Resultados

Guardar cada sesion como CSV. El guardado genera:

- `nombre.csv`: eventos de la sesion, con 10 columnas.
- `nombre_palanqueos.csv`: cada presion de palanca y su fase.

Los `.mat` dentro de `Valentia/` son estado interno, no resultados finales.

## Para Desarrolladores

La fuente de verdad es este repositorio en `main`; la copia del Escritorio es
un despliegue para prueba. Antes de reemplazar archivos en la PC: prueba sin
hardware, prueba corta supervisada, revision de ambos CSV y bitacora. No mover
ni borrar `Valentia/valentia`: contiene la capa de sensores y actuadores.
