# Either `command -v` or `type` would work.
cmd_exist() { type "$1" &>/dev/null; }

#
# General alias
#

alias l='ls -1AF'
alias ll='ls -lhAF'
alias rm='rm -i'
alias rg='rg -S'
alias ta='tmux attach -t'
alias rsync='rsync --verbose --progress --human-readable --compress --archive'
alias reboot='echo $FG[red]You shall not reboot :P$FG[none]'     # no reboot via commands!
alias shutdown='echo $FG[red]You shall not shutdown :P$FG[none]' # no shutdown via commands!
alias clera='clear'
alias cl='clear'
# some commands like mv are aliased to `nocorrect $cmd` and sudo can't handle nocorrect
# so just don't use that?
# https://unix.stackexchange.com/questions/260563/sudo-nocorrect-command-not-found
# https://superuser.com/questions/749314/how-do-you-set-alias-sudo-nocorrect-sudo-correctly
# alias sudo='sudo ' # https://linuxhandbook.com/run-alias-as-sudo/

#
# Git alias
#

alias git='LANG=en_US.UTF-8 git'
alias g='git'
alias gama='git am --abort'
alias gamc='git am --continue'
alias gams='git am --skip'
alias gab='git absorb -r'
alias gau='git add -u'
alias gbu='git branch -u'
alias gca='git commit --amend'
alias gcf='git commit --fixup'
alias gcnv='git commit --amend --no-verify'
alias gcs='git commit --amend --no-verify --signoff'
alias gcp='git cherry-pick --ff --empty=drop'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcps='git cherry-pick --skip'
alias gd='git diff'
alias gdh='git diff HEAD'
alias gdhh='git diff HEAD~'
alias gds='git diff --staged'
alias gfix='git log --pretty=fixes -1'
alias gl='git log'
alias glf='git log --follow'
alias glg='git log --grep'
alias glo='git log --pretty=onelinev2'
alias gloa='git log --pretty=onelinev3'
alias glp='git log -p'
alias gnp='git --no-pager'
alias gp='git pull'
alias grb='git rebase --interactive'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbs='git rebase --skip'
alias gref='git reflog --pretty=reflog'
alias grh='git reset --hard'
alias grs='git reset --soft'
alias gsh='git show'
alias gst='git status'

# Call git-commit-lost directly
alias gcl &>/dev/null && unalias gcl

#
# Jujutsu alias
#
alias j='jj'
alias jab='jj abandon'
alias jc='jj commit'
alias jd='jj diff'
alias je='jj edit'
alias jeh='jj eh'
alias jl='jj log'
alias jll='jj ll'
alias jrb='jj rebase'
alias jsh='jj show'
alias jsp='jj split'
alias jsq='jj squash'
alias jst='jj status'
alias jtug='jj tug'

#
# Conditional alias
#

if cmd_exist nvim; then
    # use nvim where possible
    export EDITOR='nvim'
    export VISUAL='nvim'
    alias vim='nvim'
    alias vimdiff='nvim -d'
else
    # workaround for slow "xsmp init" on start
    alias vim='vim -X'
    # nvim fall back to vim
    alias nvim='vim'
fi
cmd_exist colordiff && alias diff='colordiff'
cmd_exist bat && alias cat='bat -p'
cmd_exist tmx2 && alias tmux='tmx2'
cmd_exist duf && alias df='duf'
cmd_exist dust && alias du='dust'
cmd_exist eza && alias ls='eza -F --icons=never'
cmd_exist ipython && alias ipy='ipython'
if cmd_exist python; then
    alias py='python'
elif cmd_exist python3; then
    alias py='python3'
fi

#
# OS specific
#

# macOS
if [[ "$OSTYPE" =~ ^darwin ]]; then
    # Use commands from coreutils
    alias timeout='gtimeout'
    alias date='gdate'
fi

# Goobuntu or CrOS chroot
if ([[ -f /etc/lsb-release ]] && grep "GOOGLE_ID=Goobuntu" /etc/lsb-release >/dev/null) ||
    [[ -n $CROS_WORKON_SRCROOT ]]; then

    alias rs='repo sync -j 16 --no-interleaved'
    alias rsa='rs -n --optimized-fetch && rs --auto-gc -l'
    alias rsc='rs -n --optimized-fetch -c && rs --auto-gc -l'

    alias kerup='cd ${HOME}/chromiumos/src/third_party/kernel/upstream'
    alias ker54='cd ${HOME}/chromiumos/src/third_party/kernel/v5.4'
    alias ker510='cd ${HOME}/chromiumos/src/third_party/kernel/v5.10'
    alias ker515='cd ${HOME}/chromiumos/src/third_party/kernel/v5.15'
    alias ker61='cd ${HOME}/chromiumos/src/third_party/kernel/v6.1'
    alias ker66='cd ${HOME}/chromiumos/src/third_party/kernel/v6.6'
    alias ker612='cd ${HOME}/chromiumos/src/third_party/kernel/v6.12'
    alias ker='ker66'

    alias ec='cd ${HOME}/chromiumos/src/platform/ec'
    alias scr='cd ${HOME}/chromiumos/src/scripts'

    alias gcertchk='gcertstatus --quiet --check_remaining=4h --check_ssh=false || gcert'
    alias work='gcertchk; [[ $(hostname -s) =~ v9 ]] && ssh glinux'

    alias abtd='/google/bin/releases/atp-dev/tools/forrest-mpm/forrest-mpm/forrest.par'

    alias gemini='gemini --gfg'

    # CrOS chroot specific
    if [[ -n $CROS_WORKON_SRCROOT ]]; then
        alias cwh='cros_workon --host'
        alias cwk='cros workon --board kukui'
        alias cwa='cros workon --board asurada'
        alias cwch='cros workon --board cherry'
        alias cwco='cros workon --board corsola'
        alias cwg='cros workon --board geralt'
        alias cwr='cros workon --board rauru'
        alias cws='cros workon --board skywalker'
        alias cw='cwr'

        alias dut-power='dut-power --vbat-rate=10'
        alias dut-power-s3='dut-power --vbat-rate=0'
        alias test_that='test_that --fast --autotest_dir=${HOME}/chromiumos/src/third_party/autotest/files'
        alias sv='sudo I_NEED_SERVOD=1 servod --device-discovery=none'

    else
        # Only allowed outside of CrOS chroot
        alias cr='[[ $PWD =~ ^${HOME}/chromiumos(/|$) ]] || cd ${HOME}/chromiumos; cros_sdk --no-ns-pid --no-update'
        alias enter-chrome-sdk="cros chrome-sdk --board=${BOARD} --log-level=info --internal \
          --gn-extra-args='enable_nacl=false symbol_level=1 use_remoteexec=true dcheck_always_on=false is_official_build=false'"
    fi
fi
