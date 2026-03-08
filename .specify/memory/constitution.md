<!--
Sync Impact Report
- Version change: 1.0.0 -> 2.0.0
- Modified principles:
  - I. Spec-First Delivery (NON-NEGOTIABLE) -> I. Code Quality by Default (NON-NEGOTIABLE)
  - II. Story-Scoped Incremental Delivery -> II. Testing Standards as Release Gates
  - III. Evidence-Based Quality Gates -> III. Consistent User Experience
  - IV. Automation and Reproducibility -> IV. Performance Budgets and Accountability
- Added sections:
  - None
- Removed sections:
  - V. Safety and Traceability
- Templates requiring updates:
  - [x] updated .specify/templates/plan-template.md
  - [x] updated .specify/templates/spec-template.md
  - [x] updated .specify/templates/tasks-template.md
  - [x] updated .specify/templates/commands/*.md
- Runtime guidance updates:
  - [x] updated .specify/memory/execution-contract.md
- Follow-up TODOs:
  - None
-->

# Jiaocai Spec-Kit Constitution

## Core Principles

### I. Code Quality by Default (NON-NEGOTIABLE)
Every production code change MUST pass formatter, linter, and static checks
defined by the project stack before review. New code MUST be readable,
maintainable, and free of unresolved TODO/FIXME placeholders unless explicitly
tracked in feature artifacts.
Rationale: consistent code quality reduces defect injection and keeps long-term
maintenance cost under control.

### II. Testing Standards as Release Gates
Behavior changes MUST include automated tests at the appropriate level
(unit/integration/contract/end-to-end). Each feature MUST define a test plan,
expected coverage for changed areas, and failure-first validation where
practical. Any test omission MUST include written rationale and manual steps.
Rationale: formal testing standards convert quality intent into repeatable
release criteria.

### III. Consistent User Experience
User-facing changes MUST conform to shared UX patterns for layout, terminology,
interaction behavior, and accessibility. Acceptance criteria MUST include UX
consistency checks for affected screens/flows, including keyboard navigation and
clear error/recovery messaging.
Rationale: consistency improves usability, trust, and supportability across the
product surface.

### IV. Performance Budgets and Accountability
Each feature MUST define measurable performance budgets (for example latency,
render time, memory, bundle size, or throughput) relevant to its scope. Changes
that exceed budget thresholds MUST be blocked or explicitly waived with owner,
impact, and remediation timeline.
Rationale: explicit budgets prevent gradual regressions and keep performance
visible in everyday delivery decisions.

## Operational Constraints

- Feature artifacts MUST use the canonical flow:
  `spec.md -> plan.md -> tasks.md -> implementation`.
- Each feature specification MUST define:
  code quality checks, testing strategy, UX consistency criteria, and
  performance budgets.
- Governance and template changes MUST include same-commit sync updates to
  affected templates and guidance files.
- Waivers for quality, testing, UX, or performance gates MUST include owner,
  rationale, and a time-bounded follow-up task.

## Workflow and Review Process

1. Start from a clear feature description and generate or update `spec.md`.
2. Encode quality, testing, UX, and performance expectations in the spec before
   planning.
3. Produce `plan.md` with an explicit Constitution Check gate.
4. Generate `tasks.md` with dedicated tasks for quality checks, tests, UX
   validation, and performance verification.
5. Execute tasks incrementally and keep evidence (commands/results) for each
   quality gate.
6. Before completion, run required checks and record outcomes in feature
   artifacts.

Review expectations:
- Reviews MUST block merges when constitutional principles are violated.
- Violations MAY be accepted only with explicit written justification in the
  relevant artifact and reviewer sign-off.

## Governance

This constitution supersedes informal practice for this repository.
Amendments MUST:

1. Include a clear rationale and impact summary.
2. Update dependent templates and guidance in the same change set.
3. Apply semantic versioning to this constitution:
   - MAJOR: incompatible principle removal or redefinition.
   - MINOR: new principle/section or materially expanded governance.
   - PATCH: wording clarification without semantic change.

Compliance checks MUST run during planning and review. Non-compliant changes
MUST be fixed or explicitly waived with documented justification.

**Version**: 2.0.0 | **Ratified**: 2026-03-08 | **Last Amended**: 2026-03-08
