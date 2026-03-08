---
description: Generate dependency-ordered tasks for implementation.
handoffs:
  - label: Implement Tasks
    agent: speckit.implement
    prompt: Execute tasks in dependency order with evidence.
---

## User Input

```text
$ARGUMENTS
```

You MUST consider the user input before proceeding.

## Required Flow

1. Load `spec.md`, `plan.md`, and `.specify/templates/tasks-template.md`.
2. Generate tasks grouped by user story and priority.
3. Include explicit gate evidence tasks:
   - Code quality verification tasks.
   - Automated testing tasks and manual fallback tasks when waived.
   - UX consistency validation tasks for user-facing changes.
   - Performance measurement and budget validation tasks.
4. Ensure dependencies are explicit and execution order is deterministic.
5. Report the tasks file path and any required manual follow-ups.
