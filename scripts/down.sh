#!/usr/bin/env bash
# Tear the demo down
set -euo pipefail
k3d cluster delete gitops-demo
