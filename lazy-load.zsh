if cmd_exist rbenv; then
  local RBENV_SHIMS="${RBENV_ROOT:-$HOME/.rbenv}/shims"
  export PATH="$PATH:$RBENV_SHIMS"
  function rbenv() {
    unset -f rbenv &> /dev/null
    eval "$(command rbenv init -)"
    rbenv "$@"
  }
fi

export PYENV_ROOT="$HOME/.pyenv"
cmd_exist pyenv || export PATH="$PATH:$PYENV_ROOT/bin"
if cmd_exist pyenv; then
  function pyenv() {
    unset -f pyenv &> /dev/null
    eval "$(command pyenv init -)"
    pyenv "$@"
  }
fi
