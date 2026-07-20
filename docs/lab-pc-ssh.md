# Conexion SSH A La PC Del Laboratorio

## Proposito Y Limite

Esta guia recupera la conexion a la PC de la caja sin abrir MATLAB, la GUI ni
el hardware. Una direccion IP cambia; la identidad de la PC se confirma con su
nombre, su MAC de Ethernet y, finalmente, su huella SSH.

**No usar una IP historica como si fuera actual.** Las direcciones
`10.10.50.151` y `10.10.50.33` son solo antecedentes. El 18-jul-2026 la Mac
estaba en `10.10.212.23/22`, una red distinta a `10.10.50.x`; por ello no puede
consultar ARP ni encontrar esa PC directamente.

## Identidad Conocida

- Nombre Windows: `DESKTOP-LAB-S`.
- Usuario SSH: `alberto`.
- Llave privada en la Mac: `~/.ssh/caja_valentia_lab_ed25519`.
- Huella esperada para `ssh-ed25519`:
  `SHA256:cIzC7+pRZJKZsOAlFaWY/h8ncN2JD9IBC2CmuWtkUmw`.
- MAC de la tarjeta Ethernet de la PC: **pendiente de registrar**. No se debe
  inventar ni sustituir con la MAC de Wi-Fi de la Mac.

La huella SSH identifica el servidor incluso si recibe otra IP. Si la huella
no coincide, detenerse: puede ser otra computadora o una reinstalacion que se
debe verificar fisicamente.

## Recuperacion Desde La PC Del Laboratorio

Con una persona frente a Windows, abrir **PowerShell** y ejecutar:

```powershell
hostname
ipconfig
Get-NetAdapter -Physical | Select-Object Name, Status, MacAddress, LinkSpeed
Get-Service sshd
```

Anotar la IPv4 del adaptador Ethernet que este `Up`, su `MacAddress` y el
nombre del adaptador. Si `sshd` no esta `Running`, iniciar solo ese servicio
con autorizacion del responsable de la PC; no abrir MATLAB ni ejecutar el
programa de la caja para diagnosticar red.

## Recuperacion Desde La Mac

Primero comprobar que la Mac este en la **misma subred Ethernet** que la PC:

```bash
networksetup -getinfo Wi-Fi
```

ARP solo relaciona IP y MAC dentro de la red local; no cruza routers/VLAN. Por
eso `arp -an` no puede resolver una PC de `10.10.50.x` mientras la Mac esta en
`10.10.212.x`.

Una vez que la Mac este en la red de laboratorio y ya se conozca la MAC de
Ethernet de `DESKTOP-LAB-S`, el administrador autorizado puede hacer un
descubrimiento limitado al segmento conocido, sin escanear puertos:

```bash
sudo nmap -sn -PR -n 10.10.50.0/24
arp -an
```

Buscar la MAC anotada de la PC en la salida. `nmap -sn` hace solo descubrimiento
de equipos; en una LAN Ethernet usa ARP para obtener sus MAC. No ampliar el
rango ni usar un escaneo de puertos sin autorizacion expresa de la red.

Si la Mac no puede unirse a esa red, la alternativa correcta es consultar el
router/DHCP del laboratorio o leer la IPv4 directamente en la PC. No crear una
entrada ARP estatica: eso no descubre una IP y puede dirigir la conexion al
equipo equivocado.

## Verificacion Y Conexion

Para cada IP candidata, confirmar primero su huella sin guardar cambios:

```bash
ssh-keyscan -T 5 -t ed25519 IP_CANDIDATA 2>/dev/null | ssh-keygen -lf -
```

Debe coincidir exactamente con la huella `SHA256` anotada arriba. Solo despues:

```bash
ssh -i ~/.ssh/caja_valentia_lab_ed25519 alberto@IP_CANDIDATA
```

Tras recuperar la conexion, actualizar esta guia con fecha, IPv4 vigente, MAC
Ethernet y nombre del adaptador. Mantener las IP anteriores como historial, no
como configuracion activa.

## Fuentes

- Microsoft: [ARP cache en Windows](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/arp).
- Microsoft: [Get-NetNeighbor y la relacion IP/MAC](https://learn.microsoft.com/en-us/powershell/module/nettcpip/get-netneighbor?view=windowsserver2025-ps).
- Nmap: [descubrimiento de hosts y ARP en una LAN](https://nmap.org/book/man-host-discovery.html).
