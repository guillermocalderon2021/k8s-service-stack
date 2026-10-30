#!/usr/bin/env bash
set -euo pipefail
CLUSTER="${CLUSTER:-devops-local}"
K3S_IMAGE="${K3S_IMAGE:-rancher/k3s:v1.35.2-k3s1}"
HTTP_PORT="${HTTP_PORT:-8081}"
for tool in docker k3d kubectl; do command -v "$tool" >/dev/null || { echo "Falta $tool" >&2; exit 1; }; done
docker info >/dev/null
if k3d cluster list -o json | grep -Eq "\"name\"[[:space:]]*:[[:space:]]*\"${CLUSTER}\""; then
  echo "Ya existe el clúster $CLUSTER; se conserva."; exit 0
fi
k3d cluster create "$CLUSTER" --servers 1 --agents 0 --image "$K3S_IMAGE" --port "127.0.0.1:${HTTP_PORT}:80@loadbalancer" --wait
kubectl config use-context "k3d-${CLUSTER}"
kubectl get nodes -o wide
