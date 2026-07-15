# Restauracion De La Base De ValentiaE

## Decision

`main` vuelve a la base funcional `b52745b` y conserva solo dos cambios de
interfaz que no alteran luces, sonido, secuencias ni reglas de eventos:

1. Reloj visible de habituacion inicial y final.
2. Aviso LED final opcional: pulso de 100 ms cada segundo mientras se muestra
   el dialogo de guardado.

## Excluido De Esta Base

- `Max evento mismo lado` y cualquier limite nuevo de evento.
- Cambios posteriores de conteo, cierre, columnas de resultados y planificacion
  de sonido solo.
- Cambios de Cruces Peligrosos.

## Trazabilidad

La fuente se construyo desde `b52745b`, mas los commits historicos `dc8a51f`
(reloj) y `f546242` (LED). La suite sin hardware paso antes de integrar esta
restauracion a `main`.

La rama experimental anterior se conserva como historial y no es la fuente
ejecutable actual.
