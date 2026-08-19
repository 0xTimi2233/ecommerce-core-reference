---
name: review-convergence
description: Run an evidence-based review through bounded disposition, repair, and convergence.
---

# Review convergence

Use this skill for any review with a declared scope.

1. Scan the entire declared scope once. Report every evidence-supported issue together. **Done when each finding has a file and line or reproducible evidence, impact, and minimal fix**
2. Supply evidence; do not make acceptance decisions. The orchestrator records `accept`, `reject`, or `defer` for every finding. **Done when every finding has a disposition**
3. Repair only accepted P0/P1 findings. P2 and optional improvements do not start another loop by default. **Done when the repair set matches accepted scope**
4. Re-review only accepted findings, repair regressions, and previously blocked findings with new evidence. **Done when the review does not expand into new optimization work**
5. Stop after initial review, one repair, and one convergence review. If a real P0 remains, allow one more bounded repair; otherwise record residual risk. **Done when the stopping reason is explicit**
