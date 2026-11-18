---
name: grill-me
description: >-
  Stress-test a plan, architecture decision, or design through a relentless
  one-question-at-a-time interview. Trigger when validating architectural
  designs, trade-offs, or implementation plans with the user.
tags: [workflow, design, interview, planning]
---

# Grill Me (Interactive Stress-Testing)

## Workflow

1.  **Self-Serve Facts**: Query the codebase, docs, and logs for objective facts
    first; reserve questions strictly for architectural trade-offs and policy
    decisions (Good: asking which RPC protocol to adopt; Bad: asking which file
    defines a struct).
2.  **Traverse Decision Tree**: Resolve foundational choices before dependent
    sub-choices. Ask **one question per turn** paired with a recommended option
    and technical rationale, then stop generating:

    > **Question (<Topic Title>)**: [Single direct question on a trade-off or
    > design choice]
    >
    > **Recommendation**: [Proposed option + brief technical rationale]

3.  **Confirm Shared Plan**: Once all branches are resolved, output a structured
    summary of agreed decisions and trade-offs and request user approval.

## Constraints

-   **Confirmation Gate**: NEVER write production code, mutate files, or run
    destructive commands before the user approves the consolidated plan in Step
    3, to prevent unverified modifications.
