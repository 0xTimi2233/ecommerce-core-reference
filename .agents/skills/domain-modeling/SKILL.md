---
name: domain-modeling
description: Model a bounded business rule, state transition, or boundary before implementation.
---

# Domain modeling

Use this skill when a change introduces or changes a business concept, invariant, state transition, or collaboration boundary.

1. Name the behavior in user-observable terms and identify the bounded context. **Done when the behavior and owner are unambiguous**
2. Write the invariant, allowed transitions, rejected transitions, and observable facts. **Done when a test could distinguish each allowed and rejected path**
3. Separate local rules from cross-boundary inputs and outputs; state what remains unknown. **Done when no adjacent component needs to inspect private state**
4. Record alternatives and exclusions in the governing Artifact when a decision is not settled. **Done when implementation is not guessing at a policy**

Keep language ubiquitous: one term for one concept. Prefer examples that expose a rule over entity lists that merely describe storage.
