# Zsh profiling, to measure:
# ZPROF=1 zsh -i -c exit
[[ -n $ZPROF ]] && zmodload zsh/zprof

#
# Executes commands at the start of an interactive session.
#

# Dedup fpath array.
typeset -gU fpath

# For Zsh completion and function definitions.
fpath=(
  "$HOME/.local/share/zsh-completions"
  $fpath
)

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    # shellcheck disable=SC1091
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#
# Customize to your needs...
#

# Either `command -v` or `type` would work.
if_has() { command -v "$1" &>/dev/null; }

# shellcheck disable=SC1090
chk_src() { [[ -f "$1" ]] && source "$1"; }

#
# Exports
#

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Customize debug mode prompt for `set -x`
export PS4='$0:$LINENO++> '

# FZF options
export FZF_DEFAULT_COMMAND="fd --type f --follow --hidden --exclude .git"
export FZF_DEFAULT_OPTS="
  --color=fg:#cdcdcd,fg+:#e0e0e0,bg:#202030,bg+:#404040
  --color=hl:#6bb6ff,hl+:#fc8f00,info:#eaeaae,marker:#74e560
  --color=prompt:#cba6f7,spinner:#af5fff,pointer:#af5fff
  --color=header:#87afaf,border:#505050,query:#e0e0e0
"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
--preview 'bat --color=always --style=auto --theme=OneHalfDark --line-range=:100 {}'
"
export FZF_ALT_C_COMMAND="fd --type d"

#
# Sources
#

chk_src "$HOME/.utils.zsh"
chk_src "$HOME/.alias.zsh"
chk_src "$HOME/.work.zsh"
chk_src "$HOME/.local.zsh"

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
    # shellcheck disable=SC2086,SC2128
    zstyle ':completion:*:(ssh|scp|sftp|rsync):*' hosts ${host_list}
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

if_has mise && eval "$(mise activate zsh)"
if_has zoxide && eval "$(zoxide init zsh)"
if_has fzf && eval "$(fzf --zsh)"

# Starship for shell prompt - https://starship.rs
# if_has starship && eval "$(starship init zsh)"

# Terminal mouse reporting mode recovery for SSH, herdr, and tmux
_flag_mouse_reset_cmd() {
    [[ "$2" =~ "^[[:space:]]*(ssh|herdr|tmux)([[:space:]]|$)" ]] && _need_mouse_reset=1
}

# Reset VT100/SGR mouse reporting (1000/1002/1003/1006) & restore cursor (25) to
# fix stuck 31;33M escape sequences after abnormal SSH/TUI exits
_reset_stuck_mouse_mode() {
    if (( _need_mouse_reset )); then
        printf '\e[?1000l\e[?1002l\e[?1003l\e[?1006l\e[?25h' 2>/dev/null
        _need_mouse_reset=0
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _flag_mouse_reset_cmd
add-zsh-hook precmd _reset_stuck_mouse_mode

# Customized Pure.zsh
fpath+=("$HOME/dotfiles/modules/pure")
autoload -U promptinit; promptinit
prompt pure

# Zsh profiling
[[ -n $ZPROF ]] && zprof
