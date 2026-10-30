#!/usr/bin/env bash
set -euo pipefail
CLUSTER="${CLUSTER:-devops-local}"
CTX="k3d-${CLUSTER}"
POD="$(kubectl --context "$CTX" -n devops-demo get pods -l app=postgres -o jsonpath='{.items[0].metadata.name}')"
echo "Se reemplazará el Pod: $POD"
kubectl --context "$CTX" -n devops-demo delete pod "$POD"
kubectl --context "$CTX" -n devops-demo rollout status deployment/postgres --timeout=180s
kubectl --context "$CTX" -n devops-demo get pod -l app=postgres
