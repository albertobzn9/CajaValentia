# 2026-06-12 - Operacion Remota Y GUI Experimental (Historico)

> Esta decision registra la etapa USB/GUI experimental. No es una instruccion
> de despliegue actual. Para el runtime vigente, consultar
> [mapa de versiones](../version-map.md) y
> [comportamiento actual](../current-runtime-behavior-and-known-limitations.md).

## Contexto

La caja funciona con MATLAB R2011a y codigo legacy. La prioridad es modernizar y
limpiar sin romper la version que ya permite entrenar animales. La computadora
del lab es vieja, critica y sensible a fecha/hora, drivers y actualizaciones.

## Decision

En ese momento se mantuvieron tres lineas separadas:

- `06_matlab_limpio_usb`: entonces el runtime estable para sesiones reales.
- `09_matlab_experimental_gui_minima`: experimento MATLAB con GUI reducida.
- `10_paquetes_para_lab`: paquetes versionados para copiar/probar.

No mover todavia estas carpetas a una estructura `src/` o `matlab/` aunque sea
mas estetica. Primero se estabiliza y documenta el flujo.

## Operacion Remota

Se habilito SSH en `DESKTOP-LAB-S` para evitar el ciclo lento de USB ida/vuelta.
La conexion usa llave:

```bash
ssh -i ~/.ssh/caja_valentia_lab_ed25519 alberto@10.10.50.151
```

La computadora se deja con red local para SSH, pero sin ruta general a internet
cuando no se necesita, porque Windows/Office Update satura el HDD.

## MATLAB

Usar ruta explicita a R2011a:

```text
C:\Program Files (x86)\MATLAB\R2011a\bin\matlab.exe
```

No usar `matlab` por PATH porque puede resolver a R2021b.

## GUIs Visibles

Lanzar GUI directamente desde SSH no fue suficiente. La forma que funciono para
mostrar MATLAB en la pantalla del operador fue una tarea programada interactiva:

```cmd
schtasks /Create /TN CMC_Open_LuzComida /TR "Z:\09_matlab_experimental_gui_minima\cmc_open_luz_comida_r2011a.cmd" /SC ONCE /ST 23:59 /F /IT
schtasks /Run /TN CMC_Open_LuzComida
```

Esto debe usarse solo con supervision frente a la caja.

## Consecuencias

- La documentacion nueva de proceso vive en `docs/`.
- La documentacion operacional especifica vive en `11_operacion_lab/`.
- La copia estable no se toca para experimentos.
- La GUI experimental puede evolucionar rapido sin poner en riesgo sesiones
  reales.
- La migracion a Python queda pospuesta hasta cerrar contrato conductual,
  hardware y pruebas de equivalencia.
