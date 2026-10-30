#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLUSTER="${CLUSTER:-devops-local}"
docker build -t devops-api:local "$ROOT/app"
k3d image import devops-api:local -c "$CLUSTER"
echo "Imagen local importada al clúster $CLUSTER"
