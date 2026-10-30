#!/usr/bin/env bash
set -euo pipefail
CLUSTER="${CLUSTER:-devops-local}"
HTTP_PORT="${HTTP_PORT:-8081}"
BASE="http://127.0.0.1:${HTTP_PORT}"
kubectl --context "k3d-${CLUSTER}" -n devops-demo get deploy,pods,svc,pvc,ingress
printf '\nHealth:\n'
curl --fail-with-body -sS "$BASE/health"; echo
printf '\nConfiguración (sin secretos):\n'
curl --fail-with-body -sS "$BASE/config"; echo
printf '\nCrear nota:\n'
curl --fail-with-body -sS -X POST "$BASE/notes" -H 'Content-Type: application/json' -d '{"text":"Registro de prueba"}'; echo
printf '\nConsultar notas:\n'
curl --fail-with-body -sS "$BASE/notes"; echo
