# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# General function
command_exist() { command -v "$1" &> /dev/null; }
grep_words() {
  f="$(grep -rial "$1" . 2>/dev/null)"
  shift
  while (($#)); do
    f="$(echo $f | xargs -d '\n' grep -rial $1 2>/dev/null)"
    shift
  done
  echo $f | tr ' ' '\n' | sort -n
}

# General alias
alias l='ls -l'
alias ll='ls -lhAF'
alias rm='rm -i'
alias rg='rg -S'
alias ta='tmux attach -t'
alias sudo='sudo ' # https://linuxhandbook.com/run-alias-as-sudo/
alias rsync='rsync -azvhP' # rsync params: archive, compress, verbose, readable, progress
alias trim='sed -e '"'"'s/[[:space:]]*$//'"'"''  # trimming tailing spaces
alias reboot='echo You shall not reboot :P'  # no reboot via commands!
alias shutdown='echo You shall not shutdown :P'  # no shutdown via commands!

# Git alias
alias g='git'
alias gau='git add -u'
alias gca='git commit --verbose --amend'
alias grl="git reflog --format='%C(auto)%h %<(9)%gd %C(blue)%ci%C(reset) %s'"
alias gd='git diff'
alias gdh='git diff HEAD'
alias gdhh='git diff HEAD~'
alias grh='git reset --hard'
alias grs='git reset --soft'

# Conditional alias
cmd_exist nvim && alias vim='nvim' || alias vim='vim -X' # To workaround slow "xsmp init" on start
cmd_exist colordiff && alias diff='colordiff'
cmd_exist tmx2 && alias tmux='tmx2'
cmd_exist python && py='python'
cmd_exist python3 && py='python3'

#
# OS specific
#

# macOS
if [[ "$OSTYPE" =~ ^darwin ]]; then
  ;
fi

# Linux
if [[ "$OSTYPE" =~ ^linux ]]; then
  # if DISPLAY is unset, get an open display for it
  export DISPLAY=${DISPLAY:-$(w -oush | grep -Eo ' :[0-9]+' | uniq | xargs;)}

  # Copy to clipboard.
  command_exist xclip && copy() { xclip -sel clip; }

  # Print the PID that occupies a port.
  # Usage: see_port <port number>
  see_port() { netstat -lnpt | awk "\$4 ~ /:$1$/ {sub(/\/.*/, \"\", \$7); print \$7}"; }
fi

# Goobuntu
if [[ -f /etc/lsb-release ]] && grep "GOOGLE_ID=Goobuntu" /etc/lsb-release >/dev/null; then
  export PATH="$PATH:$HOME/chromiumos/src/platform/dev/contrib"
  export PATH="$PATH:$HOME/chromiumos/src/private-overlays/project-cheets-private/scripts"
  export PATH="$PATH:$HOME/chromiumos/src/config/bin"
  export PATH="$PATH:$HOME/chromiumos/chromite/contrib"

  alias rs='repo sync .'
  alias rsa='repo sync -j 16 -n && repo sync -j 16 -l'
  alias ker419='cd ~/chromiumos/src/third_party/kernel/v4.19'
  alias ker54='cd ~/chromiumos/src/third_party/kernel/v5.4'
  alias ker510='cd ~/chromiumos/src/third_party/kernel/v5.10'
  alias ker515='cd ~/chromiumos/src/third_party/kernel/v5.15'
  alias ker61='cd ~/chromiumos/src/third_party/kernel/v6.1'
  alias ker='ker510'
  alias scr='cd ~/chromiumos/src/scripts'
  alias g3doc='g4d test && cd experimental/users/fshao/g3doc && vim ./sheet.md'

  # Parse dut-power summary.
  # usage: summary <dut-power summary>
  summary() { awk '/pp/ && !/ppdut5|ppchg5/ {print $4}' "$@" | copy; }

  # git new branch.
  # usage: gnb <new branch name> [<upstream branch>]
  gnb() { git checkout -b "$1" "${2:-m/main}"; }

  # CrOS chroot
  if [[ -n $CROS_WORKON_SRCROOT ]]; then
    alias cwh='cros_workon --host'
    alias cwk='cros-workon-kukui'
    alias cwa='cros-workon-asurada'
    alias cwch='cros-workon-cherry'
    alias cwco='cros-workon-corsola'
    alias cwg='cros-workon-geralt'
    alias cw='cwg'
    alias dut-power='dut-power --vbat-rate=10'
    alias dut-power-s3='dut-power --vbat-rate=0'
    alias test_that='test_that --fast --autotest_dir=~/chromiumos/src/third_party/autotest/files'
    alias servod='servod --device-discovery=none'
    alias build_image='build_image test --no-enable-rootfs-verification'

  else
    # Only allowed outside of CrOS chroot
    alias cr='cd ~/chromiumos/src; cros_sdk --no-ns-pid'
    alias chrome_sdk="cros chrome-sdk --board=${BOARD} --log-level=info --internal \
          --gn-extra-args='enable_nacl=false symbol_level=1 blink_symbol_level=0 is_official_build=false use_goma=true'"
  fi
fi
