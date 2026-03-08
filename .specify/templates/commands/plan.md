---
description: Execute planning workflow and generate plan artifacts.
handoffs:
  - label: Generate Tasks
    agent: speckit.tasks
    prompt: Generate tasks from plan artifacts.
---

## User Input

```text
$ARGUMENTS
```

You MUST consider the user input before proceeding.

## Required Flow

1. Load `spec.md`, `.specify/memory/constitution.md`, and `.specify/templates/plan-template.md`.
2. Fill technical context and resolve unknowns.
3. Run Constitution Check gates before and after design:
   - Gate 1: `spec.md -> plan.md -> tasks.md` chain and no critical ambiguity.
   - Gate 2: Code quality gates (formatter/lint/static-type checks) are defined.
   - Gate 3: Testing standards per story are defined (levels and coverage intent).
   - Gate 4: UX consistency criteria and validation approach are defined.
   - Gate 5: Performance budgets and measurement commands are defined.
4. Generate supporting artifacts required by the plan template.
5. Stop with an error if an unmet gate has no explicit waiver.
