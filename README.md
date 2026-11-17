# gitops-fleet-demo

**ArgoCD app-of-apps on k3d — GitOps delivery and drift-revert proven in CI, free to run.**

No AWS bill. Every push spins up a throwaway k3d cluster in GitHub Actions, installs ArgoCD, applies the app-of-apps root, and proves the GitOps promise: **the repo is the only source of truth, and drift gets reverted automatically.**

## Patterns demonstrated

- **App-of-apps** — one root Application spawns all others
- **AppTeam lane** — a team ships by editing only their values.yaml
- **Chart + values split** — shared chart, per-team overrides
- **Drift-revert** — ArgoCD selfHeal undoes manual kubectl changes (asserted in CI)

> Full code (bootstrap, chart, team apps, CI workflow) is being uploaded — see the import commit.
