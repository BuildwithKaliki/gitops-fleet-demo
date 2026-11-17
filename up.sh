#!/usr/bin/env bash
# Bring the whole fleet up locally: k3d + ArgoCD + root app-of-apps
set -euo pipefail

CLUSTER=gitops-demo

echo ">>> creating k3d cluster: $CLUSTER"
k3d cluster create "$CLUSTER" --wait

echo ">>> installing ArgoCD"
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl -n argocd rollout status deploy/argocd-server --timeout=180s

echo ">>> applying root app-of-apps"
kubectl apply -f bootstrap/root.yaml

echo ">>> done. watch the fleet converge:"
echo "    kubectl -n argocd get applications -w"
