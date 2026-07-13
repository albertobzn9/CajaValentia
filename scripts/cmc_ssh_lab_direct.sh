#!/bin/zsh
# Conecta desde la Mac al enlace Ethernet directo de DESKTOP-LAB-S.

set -euo pipefail

key="$HOME/.ssh/caja_valentia_lab_ed25519"
host=$(dscacheutil -q host -a name desktop-lab-s.local | \
  awk '/ip_address: 169\.254\./ {print $2; exit}')

if [[ -z "$host" ]]; then
  print -u2 'No se encontro la IP directa 169.254.* de DESKTOP-LAB-S.'
  print -u2 'Verifica que Ethernet directo este activo y vuelve a intentar.'
  exit 1
fi

exec ssh -i "$key" -o BatchMode=yes -o ConnectTimeout=8 \
  -o StrictHostKeyChecking=accept-new "alberto@$host" "$@"
