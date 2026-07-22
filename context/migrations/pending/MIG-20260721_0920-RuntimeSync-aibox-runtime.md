---
apiVersion: processkit.projectious.work/v1
kind: Migration
metadata:
  id: MIG-20260721_0920-RuntimeSync-aibox-runtime
  created: 2026-07-21T09:20:04Z
spec:
  source: aibox-runtime-home
  source_url: "aibox://runtime-home"
  from_version: 0.28.0
  to_version: 0.28.2
  state: pending
  generated_by: aibox apply
  generated_at: 2026-07-21T09:20:04Z
  summary: 0 changed upstream, 0 conflicts, 2 new, 0 removed (1 groups affected)
  affected_groups:
    - runtime-misc
  affected_files:
    - { path: .local/bin/aibox-latex-build, classification: new-upstream }
    - { path: .local/bin/aibox-latex-watch, classification: new-upstream }
---

# Migration MIG-20260721_0920-RuntimeSync-aibox-runtime

Managed `.aibox-home/` runtime changes from `0.28.0` to `0.28.2`.

0 changed upstream, 0 conflicts, 2 new, 0 removed (1 groups affected)

## Counts

- unchanged: 42
- changed-locally-only: 0
- changed-upstream-only: 0
- conflict: 0
- new-upstream: 2
- removed-upstream: 0

- removed-upstream-stale: 0

## Changes by group

### runtime-misc

**new-upstream**

- `.aibox-home/.local/bin/aibox-latex-build` -> `.aibox-home/.local/bin/aibox-latex-build`
- `.aibox-home/.local/bin/aibox-latex-watch` -> `.aibox-home/.local/bin/aibox-latex-watch`

