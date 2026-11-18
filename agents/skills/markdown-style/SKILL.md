---
name: markdown-style
description: >-
  Apply style and formatting guidelines to Markdown (.md) files to ensure
  high-density, skimmable documentation. Trigger when writing, editing,
  formatting, or reviewing Markdown (.md) files, or when creating engineering
  documentation.
tags: [markdown, styleguide, documentation]
---

# Markdown Style Guide

## Workflow

1.  **Draft**: Write the content following **Constraints**.
2.  **Prune**: Re-read the result and delete note blocks, summary paragraphs,
    and filler that restate surrounding text, to save reader time and context
    tokens (Bad: `> **Note**: As stated above, connect the cable.`).

## Constraints

-   **Noun-Based Headings**: Use noun phrases for section headings to facilitate
    scanning (Good: `## Installation`; Bad: `## How to Install the Tool`).
-   **Imperative Steps**: Start procedural steps with an active verb, optionally
    after a bold lead-in label (`1. **Build**: Run ...`), to maximize
    instruction adherence (Good: `1. Connect the power cable.`; Bad:
    `1. You should connect the power cable.` or
    `1. **Connect** the power cable.`).
-   **Inline Conditionals**: Embed platform or target conditions directly within
    the instruction step (Good: `For tablet: hold Power for 10 s.`; Bad: a
    detached paragraph explaining tablet behavior).
-   **Inlined Code Context**: Place path hints and flag explanations as comments
    inside code blocks rather than surrounding prose (Good: a
    `# Run from repo root` comment above `./build.sh`; Bad: a prose line "Make
    sure you are in the repo root before running:").
-   **Portable Path Variables**: Use `$HOME` instead of tilde (`~/`) for path
    definitions (Good: `$HOME/dotfiles`; Bad: unexpanded `~/` prefix), because
    `~` fails to expand inside quotes or non-interactive subshells.
-   **Proper Noun Capitalization**: Capitalize domain-specific tools and
    hardware states (Good: **Servod**, **Chroot**, **Developer Mode**; Bad:
    servod, chroot, developer mode) to distinguish specialized terms from
    generic nouns.
