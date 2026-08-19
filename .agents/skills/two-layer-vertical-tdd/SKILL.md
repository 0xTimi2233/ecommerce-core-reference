---
name: two-layer-vertical-tdd
description: Deliver one observable behavior through outer and inner TDD loops.
---

# Two-layer vertical TDD

Use this skill for a bounded Vertical Slice with one observable behavior.

1. State the outer observation: input, visible result, and boundary. Make it fail for the intended reason. **Done when the failure demonstrates the missing behavior**
2. State the smallest deterministic inner rule or transition required by that observation. Make it fail. **Done when the inner failure isolates the rule**
3. Implement only enough for the inner test to pass, then run the fast inner suite. **Done when the rule passes without unrelated behavior**
4. Connect the boundary until the outer check passes, then refactor with both checks green. **Done when the observable behavior passes and the boundary is still explicit**
5. Record commands, results, and residual risk. **Done when another reviewer can reproduce the evidence**

Do not duplicate the same rule at both layers. Keep outer checks about observable behavior and inner checks about deterministic domain logic.
