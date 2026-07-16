# Conexion SSH A La PC Del Laboratorio

## Proposito Y Limite

Este documento permite inspeccionar y mantener la copia de la caja desde la
Mac sin depender de USB. SSH **no** autoriza a iniciar una GUI ni a activar
hardware sin una persona entrenada frente a la caja.

No guardar contrasenas, llaves privadas ni datos de animales en este repo.

## Ultima Identidad Confirmada

| Dato | Valor conocido | Como usarlo |
| --- | --- | --- |
| Nombre Windows | `DESKTOP-LAB-S` | Verificar con `hostname` al conectar. |
| Usuario SSH | `alberto` | Usar solo si el usuario confirma que sigue vigente. |
| IP institucional mas reciente | `10.10.50.33` | Primer intento cuando ambas computadoras estan en la red IFC. |
| IP historica | `10.10.50.151` | No usar como primer intento; fue una direccion anterior. |
| Llave privada en la Mac | `~/.ssh/caja_valentia_lab_ed25519` | Existe fuera del repo. Nunca copiarla ni versionarla. |
| Servicio Windows | `sshd` | Debe estar `Running`. |

Las IP pueden cambiar. Que una direccion aparezca aqui no prueba que sea la
actual ni autoriza a intentar comandos sobre la caja.

## Antes De Conectar

1. Confirmar con la persona en el laboratorio que la PC esta encendida, que
   hay alguien frente a la caja y que no hay una sesion conductual en curso.
2. Confirmar la ruta de red: ambas computadoras en la misma red institucional,
   o Ethernet directo con direcciones que puedan alcanzarse entre si.
3. No cambiar fecha, gateway, firewall, servicio SSH, MATLAB ni drivers como
   primer paso. Primero inspeccionar.

En Ethernet directo, no asumir que hay conectividad solo porque el cable esta
conectado. Pedir `ipconfig` en Windows y confirmar que el IPv4 de ambos lados
es alcanzable. Si la direccion institucional no responde, obtener la direccion
actual de Windows antes de probar otra cosa.

## Conexion Normal

Desde la Mac:

```bash
ssh -i ~/.ssh/caja_valentia_lab_ed25519 \
  -o ConnectTimeout=8 \
  alberto@10.10.50.33
```

Primero hacer una comprobacion de solo lectura:

```bash
ssh -i ~/.ssh/caja_valentia_lab_ed25519 \
  -o ConnectTimeout=8 \
  alberto@10.10.50.33 "hostname && whoami"
```

Debe responder `DESKTOP-LAB-S` y el usuario esperado. Si no, detenerse: no
asumir que se conecto a la computadora correcta.

## Si No Conecta

1. Esperar hasta agotar el `ConnectTimeout`; no abrir una GUI ni repetir
   comandos largos.
2. Pedir a la persona frente a Windows que ejecute en PowerShell:

   ```powershell
   hostname
   whoami
   ipconfig
   Get-Service sshd
   ```

3. Comparar el IPv4 informado con la red de la Mac. Usar la nueva IP solamente
   despues de que el nombre y usuario coincidan.
4. Si el servicio no esta activo, el operador local debe decidir si es
   apropiado iniciarlo. No cambiar configuracion de red o seguridad solo para
   "hacer que funcione".

La IP `10.10.50.151` pertenece a una etapa anterior. La llave host registrada
en la Mac fue compatible con ambas IP historicas, pero eso no sustituye la
verificacion de `hostname`.

## Trabajo Remoto Seguro

- Empezar por lectura: rutas, version de MATLAB, logs, resultados o `git diff`.
- Para comandos PowerShell complejos, usar `powershell -NoProfile
  -EncodedCommand ...`; evita errores de comillas dentro de SSH.
- Descargar y revisar primero logs/resultados. No inferir que una prueba
  termino hasta que el archivo esperado cambie o la persona lo confirme.
- No lanzar `matlab.exe`, una tarea programada o un `.bat` que abra GUI sin la
  confirmacion explicita de la persona junto a la caja.
- Si se requiere una GUI visible, seguir el flujo validado para la copia y
  lanzador actuales; esas rutas pueden cambiar y se deben verificar en la PC.

## Referencias Historicas Utiles

- La copia de prueba usada el 13-jul-2026 estaba en
  `C:\Users\Alberto\Documents\CajaValentia_R2011a_CierreHab_Pruebas`.
- El archivo monitor de esa copia era
  `matlab\resultados\ultima_sesion_guardada.txt`.
- Esas rutas son referencias, no contratos: confirmar la copia diaria antes de
  editar o ejecutar.

Ver tambien [START_HERE_NEW_AGENT.md](START_HERE_NEW_AGENT.md) y
[current-runtime-behavior-and-known-limitations.md](current-runtime-behavior-and-known-limitations.md).
