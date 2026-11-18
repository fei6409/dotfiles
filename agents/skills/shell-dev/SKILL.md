---
name: shell-dev
description: >-
  Develop, debug, and optimize robust Shell, Bash, and Zsh scripts. Trigger
  when writing, modifying, or debugging .sh, .bash, or .zsh scripts.
tags: [shell, bash, zsh, scripting]
---

# Shell Scripting

## Workflow

1.  **Boilerplate & Signal-Safe Traps**: Start scripts with `set -euo pipefail`
    after the shebang (`#!/bin/bash` or `#!/bin/zsh`). Route logs to `stderr`
    (`>&2`) to preserve `stdout` for pipeline data. Register `EXIT` cleanup with
    safe parameter expansion (`${TMP_DIR:-}`) to avoid unbound variable errors
    under `set -u`, and re-send `SIGINT`
    (`trap 'trap - INT; kill -s INT $$' INT`) so parent processes terminate
    cleanly:

    ```bash
    set -euo pipefail

    info() { printf "\033[32m[INFO]\033[0m %s\n" "$*" >&2; }
    warn() { printf "\033[33m[WARNING]\033[0m %s\n" "$*" >&2; }
    err()  { printf "\033[31m[ERROR]\033[0m %s\n" "$*" >&2; exit 1; }

    cleanup() { [[ -n "${TMP_DIR:-}" ]] && rm -rf "$TMP_DIR"; }
    trap cleanup EXIT
    trap 'trap - INT; kill -s INT $$' INT
    ```

2.  **Static Verification**: Validate syntax and lint before execution:

    ```bash
    bash -n <script.sh> && shellcheck <script.sh>  # use zsh -n for Zsh scripts
    ```

## Constraints

-   **Quoting Hygiene**: Quote all variable and array expansions to prevent word
    splitting and globbing (Good: `"$var"`, `"${array[@]}"`; Bad: `$var`,
    `${array[*]}`).
-   **Shell Dialect Alignment**: Prefer `[[ ... ]]`, `(( ... ))`, and `local -a`
    in Bash/Zsh; restrict scripts with `#!/bin/sh` to POSIX `[ ... ]` without
    Bashisms (Good for Bash: `[[ $count -gt 0 ]]`; Good for POSIX:
    `[ "$count" -gt 0 ]`; Bad for POSIX: `[[ $count -gt 0 ]]`).
