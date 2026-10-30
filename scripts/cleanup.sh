#!/usr/bin/env bash
set -euo pipefail
CLUSTER="${CLUSTER:-devops-local}"
printf 'Esta acción elimina el clúster %s y sus datos locales. Escriba ELIMINAR: ' "$CLUSTER"
read -r CONFIRM
[[ "$CONFIRM" == 'ELIMINAR' ]] || { echo 'Cancelado'; exit 1; }
k3d cluster delete "$CLUSTER"
