---
name: skill-feedback
description: >-
  Review the current session to write feedback on gaps in skills, AGENTS.md
  rules, or agent definitions, and improve those files from approved feedback.
disable-model-invocation: true
tags: [meta-skill, feedback, workflow]
---

# Skill Feedback

A *target* is a skill, an `AGENTS.md` rule, or an agent definition. When invoked
without a specific feedback file or edit request, run **Write Feedback** on the
current session and wait for user approval before running **Improve from
Feedback**.

## Workflow

### Write Feedback

1.  **Select Gaps**: Review the session up to this point (user corrections,
    retries, tool or review errors, and subagent reports). Keep a gap only if
    you can name the target step that was missing, ambiguous, blocked, or a dead
    end, and the gap would recur on other inputs. Skip environment failures
    (expired auth, flaky network) and input-specific facts. If no gap remains,
    write nothing and tell the user no changes are needed.
2.  **Write**: Save
    `$HOME/.local/state/agents/feedback/$(date +%Y%m%d-%H%M%S).md` with one
    section per gap:
    -   **Target**: The file, and its section or step.
    -   **Problem**: What the target made you do, or couldn't support.
    -   **Evidence**: Errors, iteration counts, or user corrections from this
        run.
    -   **Proposed change**: A change that would have prevented it.
3.  **Report**: Present the file path and a summary of each gap to the user, and
    wait for approval before editing any target.

### Improve from Feedback

1.  **Judge**: For each approved gap, decide whether it would recur and whether
    current text already covers it. Skip a gap that wouldn't recur. If covered
    text was misfollowed, treat its wording or placement as the gap: reword it
    or move it to the step that needs it, and never add a duplicate rule. If the
    target was never loaded, fix its `description` or `AGENTS.md` registry entry
    instead.
2.  **Edit**: Fix the cause in the target's rules or flow so the edit covers
    every input that would hit the gap, not only the reported one. Prefer
    generalizing or merging existing rules over adding new ones; restructure the
    flow when a new design covers more cases than patches would. Treat the
    proposed change as a hint, not a spec.
3.  **Replay**: Dispatch a fresh worker subagent with only the edited files and
    the gap's situation, and ask what it would do; a worker returns both to its
    caller to dispatch it. If the answer still hits the gap, return to step 2.
    After two failed replays, stop and report the gap as open.
4.  **Report**: List each gap as applied or skipped, with a one-line reason.
