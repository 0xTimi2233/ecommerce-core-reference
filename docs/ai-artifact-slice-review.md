# AI Artifact / Slice advisory review

The `AI Artifact / Slice review` workflow is an opt-in, advisory gate for an Artifact or Vertical Slice pull request. Apply the `ai-review: artifact-or-slice` label to a non-draft PR after its human author has declared the intended stage. The workflow produces one of `PASS`, `CHANGES_REQUIRED`, `ESCALATE`, or `FAIL_CLOSED`; the `verdict` job fails unless the validated result is `PASS`.

## Trust boundary

The workflow uses `pull_request_target` so its definition and prompt are read from the PR base revision. After Bootstrap is merged, protect `main` before using this workflow as a governance control. The analysis job checks out only the base SHA with credentials disabled; it fetches the PR metadata and diff as bounded, untrusted text. It does not check out, execute, or source Skills from the PR, and it has only read permissions.

`DEEPSEEK_API_KEY` exists only in that read-only analysis job. The separate reporting job has only `pull-requests: write`, does not check out a repository, and posts a fixed-format status after re-checking the report schema. It never posts model-generated prose. The gate has no token permissions. A transport, API, schema, or verdict-validation failure prevents a passing verdict.

The trusted reviewer prompt is `.github/review-prompts/ai-artifact-slice-review-v1.md` at the protected base revision. PR descriptions, labels, diffs, artifacts, logs, and model output are not trusted instructions.

## Enablement sequence

1. Merge Bootstrap to `main` and configure branch protection or rulesets, CODEOWNERS, and required human approval.
2. Confirm the `DEEPSEEK_API_KEY` is limited to this repository and review its rotation owner.
3. Test the workflow on a non-sensitive, labeled PR and inspect the artifact, fixed status, and failing verdict behavior.
4. Decide with maintainers whether the labeled gate is a required check for the work it governs. Do not treat an unlabeled or skipped run as an AI review.

This workflow is evidence only. Human reviewers accept, reject, or defer findings and retain all approval and merge decisions.
