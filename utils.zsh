# Find lines with all given words (in any order).
# `(?=...)` to 'lookahead' a pattern, which doesn't consume characters.
# Require `-P` flag for PCRE2 matching.
rg_all() {
    local pattern=""
    for arg in "$@"; do
        pattern+="(?=.*${arg})"
    done
    rg -P "${pattern}"
}

# Go up N levels of directories.
up() {
    local count=${1:-1}
    local dir=""
    for i in $(seq 1 "${count}"); do
        dir+="../"
    done
    cd "${dir}" || echo "Failed to 'cd ${dir}'." >&2
}

# Trim trailing whitespace and copy it to the clipboard.
trimcopy() {
    # Determine the correct copy command for the OS
    local copy_cmd
    if [[ "$OSTYPE" =~ ^darwin ]]; then
        copy_cmd=(pbcopy)
    elif [[ "$OSTYPE" =~ ^linux ]]; then
        if ! cmd_exist xclip; then
            echo "Error: xclip not found." >&2
            return 1
        fi
        copy_cmd=(xclip -sel clip)
    else
        echo "Error: Unsupported OS for trimcopy." >&2
        return 1
    fi
    sed -e 's/[[:space:]]*$//' | "${copy_cmd[@]}"
}

# Create a new Git branch and optionally set the upstream branch.
gnb() {
    if [[ -z "$1" ]]; then
        echo "Usage: gnb <new_branch_name> [[<remote>/]<upstream_branch>]"
        return 1
    fi

    git checkout -b "$1"

    [[ -z "$2" ]] && return

    local upstream=""
    local pattern="[a-zA-Z0-9._-]+"

    if [[ "$2" =~ "^${pattern}/${pattern}$" ]]; then
        upstream="$2"
    elif [[ "$2" =~ "^${pattern}$" ]]; then
        local remotes=( $(git remote show) )

        if [[ ${#remotes[@]} == 0 ]]; then
            echo "Error: No remotes."
            return 1
        fi

        if [[ ${#remotes[@]} == 1 ]]; then
            upstream="${remotes[1]}/$2"
        else
            local preferred=("goog" "cros" "origin")

            for p in "${preferred[@]}"; do
                for r in "${remotes[@]}"; do
                    if [[ "${r}" == "${p}" ]]; then
                        upstream="${p}/$2"
                        break 2 # Break both loops
                    fi
                done
            done

            if [[ -z "${upstream}" ]]; then
                echo "Error: Preferred remotes (${preferred[@]}) not found."
                echo "Available remotes:\n${remotes[@]}"
                return 1
            fi
        fi
    else
        echo "Error: Unknown upstream branch format: $2"
        echo "Usage: gnb <new_branch_name> [[<remote>/]<upstream_branch>]"
        return 1
    fi

    git branch --set-upstream-to="${upstream}"
}
