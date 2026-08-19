# ecommerce-core-reference

A governance-first reference repository for building a future ecommerce core. This Bootstrap contains workflow infrastructure only: it intentionally has no domain code, contracts, workspace, BDD catalog, or implementation claims.

## Delivery path

1. **Bootstrap** — maintain these contribution boundaries, checks, and review aids.
2. **Artifact / Spec** — agree on a bounded decision, acceptance evidence, and affected boundaries before implementation.
3. **Feature and Vertical Slices** — organize approved work, then ship one observable behavior per Slice using outer/inner TDD.
4. **Final Integration** — compose already-proven slices and validate their interfaces without introducing new domain rules.

Use the matching Issue Form. Each form states what belongs there and what does not. A Feature is planning, a Vertical Slice is an independently reviewable behavior, and Final Integration only composes prior slices.

## Review and checks

Humans retain review responsibility for every stage. The default PR template records evidence, scope, and residual risk; it is not an approval mechanism. Run the deterministic bootstrap checks before proposing governance changes:

```sh
./scripts/bootstrap-check.sh
```

The minimal CI runs those same repository checks. It validates configuration, template boundaries, and pinned Action references; it does **not** claim to test future application behavior.

## AI Artifact / Slice advisory review

A label-gated AI advisory workflow is included for Artifact and Vertical Slice PRs. It reads a trusted prompt from the base revision, analyzes bounded PR text without checking out PR code, validates a machine-readable verdict, and isolates fixed-format write-back from analysis. It can fail its verdict check, but it never approves a merge or replaces human review. Follow [the enablement sequence](docs/ai-artifact-slice-review.md) only after Bootstrap reaches protected `main`.

## Repository map

- `.github/ISSUE_TEMPLATE/` — the four work-item forms
- `.github/review-prompts/` — GitHub-specific, advisory reviewer prompts
- `.agents/skills/` — reusable engineering guidance with no GitHub credential or PR automation instructions
- `scripts/` — deterministic Bootstrap validators
- `docs/delivery-stages.md` — stage entry/exit criteria
- `docs/ai-artifact-slice-review.md` — AI advisory trust boundary and enablement
