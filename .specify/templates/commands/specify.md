---
description: Create or update the feature specification from user input.
handoffs:
  - label: Plan Feature
    agent: speckit.plan
    prompt: Build implementation plan from the completed spec.
---

## User Input

```text
$ARGUMENTS
```

You MUST consider the user input before proceeding.

## Required Flow

1. Load `.specify/templates/spec-template.md`.
2. Create or update the target `spec.md`.
3. Ensure all mandatory sections are completed.
4. Enforce Constitution Alignment checks from v2.0.0:
   - Code quality gates are defined.
   - Testing standards are defined per story.
   - UX consistency checks are explicit.
   - Performance budgets are measurable.
   - Any waiver includes owner, rationale, risk, and timeline.
5. Report the spec path and any unresolved clarifications.
