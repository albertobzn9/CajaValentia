# Brief Para Un Nuevo Agente En El Laboratorio

La CajaValentia controla estimulos reales para ratas. El repositorio canonico
es este GitHub, rama `main`; `legacy/` nunca se edita y `matlab/` es el paquete
ejecutable R2011a.

## Empieza Asi

1. Lee [`../AGENTS.md`](../AGENTS.md).
2. Lee [`START_HERE_NEW_AGENT.md`](START_HERE_NEW_AGENT.md).
3. Para trabajo con la PC del lab, lee [`lab-pc-ssh.md`](lab-pc-ssh.md).
4. Antes de editar, resume: solicitud, modulos implicados, riesgo conductual y
   prueba que demostraria que funciono.

## Reglas Cortas

- Nunca abrir MATLAB, una GUI o hardware remoto sin una persona presente junto
  a la caja.
- La ultima IP conocida fue `10.10.50.33`, pero siempre confirmar `hostname`
  (`DESKTOP-LAB-S`) y `whoami`; las IP cambian.
- No asumir que ramas, CSV de 10 columnas o contadores experimentales forman
  parte de `main`: varios pertenecen a versiones historicas retiradas.
- Antes de cambiar hardware o timing, primero prueba logica; despues prueba
  fisica corta y documentada.
- Nunca subir resultados de animales, `.mat` de sesion, llaves SSH o
  contrasenas.

Pregunta inicial sugerida:

```text
Lee AGENTS.md, docs/START_HERE_NEW_AGENT.md y docs/lab-pc-ssh.md. Resume el
estado de main y confirma una conexion SSH de solo lectura antes de proponer
cualquier cambio o prueba con la caja.
```
