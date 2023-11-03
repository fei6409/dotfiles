# Zsh profiling, to measure:
# ZPROF=1 zsh -i -c exit
[[ -n $ZPROF ]] && zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#
# Customize to your needs...
#

# Either `command -v` or `type` would work.
cmd_exist() { type "$1" &> /dev/null; }

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
cmd_exist go && export PATH="$(go env GOPATH)/bin:$PATH"

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
  export PATH="$PATH:$HOME/chromiumos/src/platform/dev/contrib"
  export PATH="$PATH:$HOME/chromiumos/src/private-overlays/project-cheets-private/scripts"
  export PATH="$PATH:$HOME/chromiumos/src/config/bin"
  export PATH="$PATH:$HOME/chromiumos/chromite/contrib"
fi

# Use truecolor
export COLORTERM=truecolor

# Use fdfind as FZF backend
export FZF_DEFAULT_COMMAND="fd --type f --follow --hidden --exclude .git"
# https://github.com/catppuccin/fzf
export FZF_DEFAULT_OPTS="
--color=bg:#1e1e2e,fg:#cdd6f4,hl:#f38ba8
--color=bg+:#313244,fg+:#cdd6f4,hl+:#f38ba8
--color=info:#cba6f7,pointer:#f5e0dc,header:#f38ba8
--color=prompt:#cba6f7,marker:#f5e0dc,spinner:#f5e0dc
"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Use bat for file preview.
export FZF_CTRL_T_OPTS="
--preview 'bat --color=always --style=numbers --line-range=:100 {}'
"
export FZF_ALT_C_COMMAND="fd --type d"

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

# Sources
[[ -f $HOME/.local.zsh ]] && source $HOME/.local.zsh
[[ -f $HOME/.fzf.zsh ]] && source $HOME/.fzf.zsh
[[ -f $HOME/.alias.zsh ]] && source $HOME/.alias.zsh
[[ -f $HOME/.lazy-load.zsh ]] && source $HOME/.lazy-load.zsh
[[ -f $HOME/.my-git-prompt.zsh ]] && source $HOME/.my-git-prompt.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f $HOME/.p10k.zsh ]] && source $HOME/.p10k.zsh

# Ensure path array do not contain duplicates
typeset -U PATH

# Zsh profiling
[[ -n $ZPROF ]] && zprof
