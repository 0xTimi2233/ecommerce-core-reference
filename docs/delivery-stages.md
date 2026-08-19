# Delivery stages

This repository uses four deliberately narrow work-item stages. Completion of a stage is evidence for human review, not automatic authorization to merge or release.

## 1. Bootstrap

Bootstrap establishes contribution rules, templates, reviewer guidance, and deterministic configuration checks. Its exit is a reviewed, reproducible governance baseline. It contains no domain assertion or implementation.

## 2. Artifact / Spec

An Artifact records a decision before code: problem, affected boundary, alternatives, acceptance evidence, and explicit exclusions. It exits when human reviewers agree that the decision is sufficiently bounded to plan. It does not create implementation work by itself.

## 3. Feature and Vertical Slice

A Feature groups a coherent approved outcome and names its dependent Artifacts. A Vertical Slice is the delivery unit: one observable behavior, its acceptance evidence, and its scope boundary. Build a Slice with outer/inner TDD and retain the real command results. A Feature is not proof that any Slice is complete.

## 4. Final Integration

Final Integration composes completed Slices and checks the behavior at their boundary. It may add composition fixtures, adapters, and integration evidence, but it must not add a new domain rule. A missing prerequisite or new rule returns work to an Artifact or Slice.

## Human review

At every transition, reviewers verify the stated boundary, evidence, exclusions, and residual risk. Automated Bootstrap checks validate repository mechanics only; they are not a substitute for design, security, or acceptance review.
