# Zsh profiling, to measure:
# ZPROF=1 zsh -i -c exit
[[ -n $ZPROF ]] && zmodload zsh/zprof

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

#
# Exports
#

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
if cmd_exist go; then
    # shellcheck disable=SC2155
    export PATH="$(go env GOPATH)/bin:$PATH"
    export GOPATH="$HOME/go"
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
fi

# Use truecolor
export COLORTERM=truecolor

# Customize debug mode prompt for `set -x`
export PS4='$0:$LINENO++> '

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

#
# Sources
#

chk_src "$HOME/.utils.zsh"
chk_src "$HOME/.alias.zsh"
chk_src "$HOME/.local.zsh"
chk_src "$HOME/.fzf.zsh"
chk_src "$HOME/.lazy-load.zsh"

#
# Others
#

# To boost ssh/scp completion speed, only consider hosts in the SSH config
if [[ -f $HOME/.ssh/config ]]; then
    host_list=($(awk '
        tolower($1) == "host" {
            for (i=2; i<=NF; i++)
                if ($i !~ /[*?]/) print $i
        }
    ' "$HOME/.ssh/config" | sort -u))
    zstyle ':completion:*:(ssh|scp|sftp):*' hosts $host_list
fi

# To boost command completion speed, only consider the following users
zstyle ':completion:*' users fei6409 fshao root

# No more type freeze after ctrl-s:
# https://superuser.com/questions/1390977/pressing-ctrl-s-by-mistake-while-using-vim
# stty -ixon

# Set file mode permission mask
umask 022

# Ensure path array do not contain duplicates
typeset -U PATH

# Setup Zoxide
cmd_exist zoxide && eval "$(zoxide init zsh)"

# Starship for shell prompt - https://starship.rs
cmd_exist starship && eval "$(starship init zsh)"

# Zsh profiling
[[ -n $ZPROF ]] && zprof
