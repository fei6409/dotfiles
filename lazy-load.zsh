if cmd_exist rbenv; then
  local RBENV_SHIMS="${RBENV_ROOT:-$HOME/.rbenv}/shims"
  export PATH="$RBENV_SHIMS:$PATH"
  function rbenv() {
    unset -f rbenv &> /dev/null
    eval "$(command rbenv init -)"
    rbenv "$@"
  }
fi

if cmd_exist pyenv; then
  function pyenv() {
    unset -f pyenv &> /dev/null
    eval "$(command pyenv init -)"
    pyenv "$@"
  }
fi
