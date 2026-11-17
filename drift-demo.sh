#!/usr/bin/env bash
# The money shot: manual kubectl change gets reverted by ArgoCD selfHeal.
set -euo pipefail

NS=test-drift
echo ">>> namespace $NS exists? (should be NO, ArgoCD manages team namespaces only)"
kubectl get ns "$NS" 2>/dev/null && echo "unexpected" || echo "correct: absent"

echo ">>> manually patching team-a deployment replicas (breaking the Git state)"
kubectl -n team-a scale deploy/$(kubectl -n team-a get deploy -o name | head -1 | cut -d/ -f2) --replicas=9

echo ">>> patched. now we watch ArgoCD selfHeal revert it (refresh + sync)..."
echo ">>> in a real demo run:  argocd app sync team-a-demo-service  then check replicas return to values.yaml count"
kubectl -n team-a get deploy -w
