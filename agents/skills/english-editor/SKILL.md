---
name: english-editor
description: >-
  Edit, refine, and translate English text with Traditional Chinese explanations.
disable-model-invocation: true
tags: [writing, english, translation, grammar, communication]
---

# English Editor

## Workflow

1.  **Revise or Translate**: Correct grammar and typos, translate Chinese to
    English, or refine phrasing as requested.
2.  **Explain Nuances**: Append a Traditional Chinese (繁體中文) bullet list with
    one single-line bullet per change (grammar fix, word choice, or phrasing
    nuance). Skip typo-only fixes.

## Constraints

-   **Zero Preamble**: Start the response directly with the target English text
    to allow immediate copying (Good: `The patch resolves...`; Bad:
    `Here is the revised text: The patch resolves...`).
-   **Default Register**: Use a concise, neutral tone unless the user specifies
    an explicit register (e.g., casual, formal, shorter) to maintain factual
    communication (Good: `The test passed.`; Bad:
    `Awesome, the test succeeded brilliantly!`).
