# SSH Directo A La PC Del Laboratorio

Usar esta ruta cuando la Mac y `DESKTOP-LAB-S` estan unidas por Ethernet
directo. No depende de la red del instituto ni de internet.

## Requisitos

- Cable Ethernet directo conectado y activo.
- SSH Server activo en la PC con el usuario `alberto`.
- Llave privada local: `~/.ssh/caja_valentia_lab_ed25519`.
- La Mac resuelve `desktop-lab-s.local` por mDNS.

## Conexion Correcta

En el repo, ejecutar:

```zsh
scripts/cmc_ssh_lab_direct.sh
```

El script descubre la direccion `169.254.*` actual de la PC y abre SSH. Esa IP
puede cambiar al reconectar el cable; no reutilizar a ciegas una IP vieja como
`10.10.50.151`, que corresponde a otra red.

Para una sola orden:

```zsh
scripts/cmc_ssh_lab_direct.sh "hostname & whoami"
```

## Verificacion Minima

La salida debe incluir:

```text
DESKTOP-LAB-S
desktop-lab-s\alberto
```

No abrir MATLAB ni ejecutar una GUI desde SSH sin una persona frente a la caja.
SSH se usa para auditoria, despliegue, pruebas sin hardware y leer logs/CSV.

## Si Falla

1. En la Mac, confirmar que `ifconfig en3` dice `status: active` y tiene una
   direccion `169.254.*`.
2. En la PC, abrir PowerShell y ejecutar `ipconfig`; buscar la IPv4 de
   Ethernet que empieza con `169.254.`.
3. Confirmar que `Get-Service sshd` dice `Running`.
4. Reintentar el script. No cambiar rutas de MATLAB por un fallo de red.
