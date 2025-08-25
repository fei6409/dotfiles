# Either `command -v` or `type` would work.
cmd_exist() { type "$1" &>/dev/null; }

# General alias
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

# Git alias
alias git='LANG=en_US.UTF-8 git'
alias g='git'
alias gama='git am --abort'
alias gamc='git am --continue'
alias gams='git am --skip'
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
alias gfix='git log --pretty=fixes -1'
alias gl='git log'
alias glg='git log --grep'
alias glf='git log --follow'
alias glo='git log --pretty=onelinev2'
alias gloa='git log --pretty=onelinev3'
alias glp='git log -p'
alias grb='git rebase --interactive'
alias gnp='git --no-pager'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbs='git rebase --skip'
alias gref='git reflog --pretty=reflog'
alias grh='git reset --hard'
alias grs='git reset --soft'
alias gsh='git show'
alias gst='git status'

# git new branch
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

# Conditional alias
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

# Linux
if [[ "$OSTYPE" =~ ^linux ]]; then
    # if DISPLAY is unset, get an open display for it
    # This is awfully slooooooow
    # export DISPLAY=${DISPLAY:-$(w -oush | grep -Eo ' :[0-9]+' | uniq | xargs;)}

    # Print the PID that occupies a port.
    # Usage: see_port <port number>
    see_port() { netstat -lnpt | awk "\$4 ~ /:$1$/ {sub(/\/.*/, \"\", \$7); print \$7}"; }
fi

# Goobuntu or CrOS chroot
if ([[ -f /etc/lsb-release ]] && grep "GOOGLE_ID=Goobuntu" /etc/lsb-release >/dev/null) ||
    [[ -n $CROS_WORKON_SRCROOT ]]; then

    alias rs='repo sync .'
    alias rsa='repo sync -j 16 -n --optimized-fetch && repo sync -j 16 -l'
    alias rsc='repo sync -j 16 -n --optimized-fetch -c && repo sync -j 16 -l'

    alias kerup='cd ${HOME}/chromiumos/src/third_party/kernel/upstream'
    alias ker419='cd ${HOME}/chromiumos/src/third_party/kernel/v4.19'
    alias ker54='cd ${HOME}/chromiumos/src/third_party/kernel/v5.4'
    alias ker510='cd ${HOME}/chromiumos/src/third_party/kernel/v5.10'
    alias ker515='cd ${HOME}/chromiumos/src/third_party/kernel/v5.15'
    alias ker61='cd ${HOME}/chromiumos/src/third_party/kernel/v6.1'
    alias ker66='cd ${HOME}/chromiumos/src/third_party/kernel/v6.6'
    alias ker612='cd ${HOME}/chromiumos/src/third_party/kernel/v6.12'
    alias ker='ker66'

    alias ec='cd ${HOME}/chromiumos/src/platform/ec'
    alias scr='cd ${HOME}/chromiumos/src/scripts'
    alias aut='cd ${HOME}/chromiumos/src/third_party/autotest/files'
    alias g3doc='g4d test && cd experimental/users/fshao/g3doc && vim ./sheet.md'

    alias gcertchk='gcertstatus --quiet --check_remaining=4h --check_ssh=false || gcert'
    alias work='gcertchk; [[ $(hostname -s) =~ v9 ]] && ssh glinux'

    # Parse dut-power summary.
    # usage: summary <dut-power summary>
    summary() { awk '/pp/ && !/ppdut5|ppchg5/ {print $4}' "$@" | copy; }

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
        alias cr='cd ${HOME}/chromiumos/src/scripts; cros_sdk --no-ns-pid --no-update'
        alias enter-chrome-sdk="cros chrome-sdk --board=${BOARD} --log-level=info --internal \
          --gn-extra-args='enable_nacl=false symbol_level=1 use_remoteexec=true dcheck_always_on=false is_official_build=false'"
    fi
fi
