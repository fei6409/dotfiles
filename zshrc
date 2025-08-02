# Zsh profiling, to measure:
# ZPROF=1 zsh -i -c exit
[[ -n $ZPROF ]] && zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$(whoami).zsh" ]]; then
#     source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$(whoami).zsh"
# fi

#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    # shellcheck disable=SC1091
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#
# Customize to your needs...
#

# Either `command -v` or `type` would work.
cmd_exist() { type "$1" &>/dev/null; }

# shellcheck disable=SC1090
chk_src() { [[ -f "$1" ]] && source "$1"; }

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

# Trim trailing whitespace and copy to clipboard.
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

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
if cmd_exist go; then
    # shellcheck disable=SC2155
    export PATH="$(go env GOPATH)/bin:$PATH"
    export GOPATH="$HOME/go"
fi

# Set file mode permission mask
umask 022

# macOS
if [[ "$OSTYPE" =~ ^darwin ]]; then
    true
fi

# Linux
if [[ "$OSTYPE" =~ ^linux ]]; then
    true
fi

# Goobuntu
if [[ -f /etc/lsb-release ]] && grep "GOOGLE_ID=Goobuntu" /etc/lsb-release >/dev/null; then
    # The initial PATH is defined in /etc/environment
    export PATH="$PATH:$HOME/depot_tools"
    export PATH="$PATH:$HOME/chromiumos/src/config/bin"
    export PATH="$PATH:$HOME/chromiumos/src/platform/dev/contrib"
    export PATH="$PATH:$HOME/chromiumos/src/private-overlays/project-cheets-private/scripts"
    export PATH="$PATH:$HOME/chromiumos/src/third_party/hdctools/scripts"
    export PATH="$PATH:$HOME/chromiumos/chromite/contrib"

    # Append chromite lib to Python import path
    export PYTHONPATH="$PYTHONPATH:$HOME/chromiumos"

    if cmd_exist go; then
        # Append Tast repos to GOPATH
        export GOPATH="$GOPATH:$HOME/chromiumos/src/platform/tast-tests"
        export GOPATH="$GOPATH:$HOME/chromiumos/src/platform/tast"
        # Append Tast dependencies
        export GOPATH="$GOPATH:$HOME/chromiumos/chroot/usr/lib/gopath"
    fi

    # g4 / p4 / Fig completion
    chk_src "/etc/bash_completion.d/p4"
    chk_src "/etc/bash_completion.d/g4d"
    chk_src "/etc/bash_completion.d/hgd"
fi

# Use truecolor
export COLORTERM=truecolor

# Use fdfind as FZF backend
export FZF_DEFAULT_COMMAND="fd --type f --follow --hidden --exclude .git"
export FZF_DEFAULT_OPTS="
  --color=fg:#cdcdcd,fg+:#e0e0e0,bg:#202030,bg+:#404040
  --color=hl:#6bb6ff,hl+:#fc8f00,info:#eaeaae,marker:#74e560
  --color=prompt:#cba6f7,spinner:#af5fff,pointer:#af5fff
  --color=header:#87afaf,border:#505050,query:#e0e0e0
"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Use bat for file preview.
export FZF_CTRL_T_OPTS="
--preview 'bat --color=always --style=auto --theme=OneHalfDark --line-range=:100 {}'
"
export FZF_ALT_C_COMMAND="fd --type d"

# Customize debug mode prompt for `set -x`
export PS4='$0:$LINENO++> '

# To boost ssh/scp completion speed, only consider hosts in the SSH config
if [[ -f $HOME/.ssh/config ]]; then
    host_list=($(grep -i '^host ' $HOME/.ssh/config | awk '{s = s $2 " "} END {print s}'))
    zstyle ':completion:*:(ssh|scp|sftp):*' hosts $host_list
fi

# To boost command completion speed, only consider the following users
zstyle ':completion:*' users fei6409 fshao root

# No more type freeze after ctrl-s:
# https://superuser.com/questions/1390977/pressing-ctrl-s-by-mistake-while-using-vim
# stty -ixon

# Setup Zoxide
cmd_exist zoxide && eval "$(zoxide init zsh)"

# Sources
chk_src "$HOME/.local.zsh"
chk_src "$HOME/.fzf.zsh"
chk_src "$HOME/.alias.zsh"
chk_src "$HOME/.lazy-load.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# chk_src "$HOME/.my-git-prompt.zsh"
# chk_src "$HOME/.p10k.zsh"

# Ensure path array do not contain duplicates
typeset -U PATH

# Starship for shell prompt - https://starship.rs
eval "$(starship init zsh)"

# Zsh profiling
[[ -n $ZPROF ]] && zprof
