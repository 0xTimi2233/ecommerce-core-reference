---
name: slice-review
description: Review a Vertical Slice for one behavior, trustworthy TDD evidence, and a preserved boundary.
---

# Slice review

Use this skill after a Vertical Slice presents implementation and evidence.

1. Verify it delivers one observable behavior linked to an approved decision. **Done when the Slice has a single, testable outcome**
2. Inspect outer evidence for a real boundary observation and inner evidence for the smallest rule. **Done when each layer tests its own responsibility**
3. Compare changed behavior with stated exclusions and prerequisites. **Done when unapproved rules and accidental integration are absent**
4. Re-run or evaluate the reported commands and classify gaps as unrun, flaky, environment-limited, or product risk. **Done when evidence claims match what was actually verified**
5. Identify review-required risks, especially contracts, irreversible effects, security, and migrations. **Done when human judgment has an explicit focus**

Use `/review-convergence` for evidence, disposition, and repair limits. A green test suite alone is not acceptance.
