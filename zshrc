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

cmd_exist() { command -v "$1" &> /dev/null; }

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.rbenv/bin"
cmd_exist go && export PATH="$PATH:$(go env GOPATH)/bin"

# For macOS
if [[ "$OSTYPE" =~ ^darwin ]]; then
	;
fi

# For Linux
if [[ "$OSTYPE" =~ ^linux ]]; then
	;
fi

# For Goobuntu
if [[ -f /etc/lsb-release ]] && grep "GOOGLE_ID=Goobuntu" /etc/lsb-release >/dev/null; then
	export PATH="$PATH:$HOME/depot_tools"
	export PATH="$PATH:$HOME/Android/Sdk/build-tools/30.0.3"
	export PATH="$PATH:/usr/lib/google-golang/bin"
fi

# Ensure path array do not contain duplicates
typeset -U PATH

# Use truecolor
export COLORTERM=truecolor

# Use fdfind as FZF backend
export FZF_DEFAULT_COMMAND="fd --type f --follow --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d"
# colorful FZF: https://github.com/rose-pine/fzf
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

# To resolve autocomplete slowness when doing ssh/scp
if [[ -f $HOME/.ssh/config ]]; then
	host_list=($(cat $HOME/.ssh/config | grep 'Host '  | awk '{s = s $2 " "} END {print s}'))
	zstyle ':completion:*:(ssh|scp|sftp):*' hosts $host_list
fi

# No more type freeze after ctrl-s:
# https://superuser.com/questions/1390977/pressing-ctrl-s-by-mistake-while-using-vim
stty -ixon

# Sources
[[ -f $HOME/.fzf.zsh ]] && source $HOME/.fzf.zsh
[[ -f $HOME/.cargo/env ]] && source $HOME/.cargo/env
[[ -f $HOME/.alias ]] && source $HOME/.alias

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f $HOME/.p10k.zsh ]] && source $HOME/.p10k.zsh

# Zsh profiling
[[ -n $ZPROF ]] && zprof
