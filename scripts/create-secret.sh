#!/usr/bin/env bash
set -euo pipefail
CLUSTER="${CLUSTER:-devops-local}"
CONTEXT="k3d-${CLUSTER}"
kubectl --context "$CONTEXT" get ns devops-demo >/dev/null || { echo 'Primero aplique k8s/01-namespace.yaml' >&2; exit 1; }
if kubectl --context "$CONTEXT" -n devops-demo get secret postgres-credentials >/dev/null 2>&1; then
  echo 'Secret postgres-credentials existente; no se modifica.'; exit 0
fi
# Contraseña ficticia generada localmente, sin escribirla en Git ni en la línea de comandos.
if command -v openssl >/dev/null; then
  PASSWORD="$(openssl rand -hex 16)"
else
  echo 'Se requiere openssl para generar el secreto de prueba.' >&2; exit 1
fi
printf %s "$PASSWORD" | kubectl --context "$CONTEXT" -n devops-demo create secret generic postgres-credentials --from-file=password=/dev/stdin >/dev/null
unset PASSWORD
echo 'Secret de prueba creado (valor no mostrado).'
