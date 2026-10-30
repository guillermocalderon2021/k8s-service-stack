#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLUSTER="${CLUSTER:-devops-local}"
CTX="k3d-${CLUSTER}"
cd "$ROOT"
kubectl --context "$CTX" apply -f k8s/01-namespace.yaml
"$ROOT/scripts/create-secret.sh"
kubectl --context "$CTX" apply -f k8s/02-configmap.yaml
kubectl --context "$CTX" apply -f k8s/03-postgres-pvc.yaml
kubectl --context "$CTX" apply -f k8s/04-postgres-deployment.yaml
kubectl --context "$CTX" apply -f k8s/05-postgres-service.yaml
kubectl --context "$CTX" -n devops-demo rollout status deployment/postgres --timeout=180s
kubectl --context "$CTX" apply -f k8s/06-api-deployment.yaml
kubectl --context "$CTX" apply -f k8s/07-api-service.yaml
kubectl --context "$CTX" apply -f k8s/08-ingress.yaml
kubectl --context "$CTX" -n devops-demo rollout status deployment/demo-api --timeout=180s
kubectl --context "$CTX" -n devops-demo get deployments,pods,services,pvc,ingress
