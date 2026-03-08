---
description: Update project constitution and synchronize dependent templates.
handoffs:
  - label: Build Specification
    agent: speckit.specify
    prompt: Implement feature specification under the updated constitution.
---

## User Input

```text
$ARGUMENTS
```

You MUST consider the user input before proceeding.

## Required Flow

1. Load `.specify/memory/constitution.md` and identify required amendments.
2. Apply semantic versioning for constitution updates.
3. Update and validate dependent templates in the same change set:
   - `.specify/templates/spec-template.md`
   - `.specify/templates/plan-template.md`
   - `.specify/templates/tasks-template.md`
   - `.specify/templates/commands/*.md`
4. Ensure constitutional principles remain explicit and testable:
   - Code quality by default
   - Testing standards as release gates
   - Consistent user experience
   - Performance budgets and accountability
5. Prepend a Sync Impact Report and output version bump rationale.
