---
name: handoff
description: >-
  Compress active conversation state into a structured handoff document for
  seamless context transfers across sessions or subagents.
disable-model-invocation: true
tags: [workflow, handoff, context, session]
---

# Handoff (Context & Session State Transfer)

## Workflow

1.  **Audit State**: Collect active workspace path, VCS revision/branch, target
    host/DUT, modified files, verified facts, open hypotheses, and debunked
    hypotheses. Label unverified assumptions as open hypotheses, never as
    verified facts, because the next session trusts the handoff without
    re-checking.
2.  **Synthesize Document**: Write
    `$HOME/.local/state/agents/handoff/handoff-$(date +%Y%m%d-%H%M%S).md`
    following [template.md](references/template.md). If the user specifies a
    focus for the next session, tailor the document to that goal.
3.  **Emit Resumption Prompt**: Output the handoff path for the next session:

    ```text
    Resume session using handoff document at:
    $HOME/.local/state/agents/handoff/handoff-<timestamp>.md
    ```

## Constraints

-   **Credential Guard**: Never write secrets, API keys, credentials, tokens, or
    SSH keys into handoff files.
-   **Code & Artifact Anchoring**: Cite modified code locations with exact
    `[file:line]` anchors to allow immediate navigation without re-searching.
    Reference existing plans, specs, commits, and diffs by path or URL instead
    of copying their contents into the handoff file, to prevent stale
    duplicates.

## References

-   [template.md](references/template.md): Session handoff document template.
