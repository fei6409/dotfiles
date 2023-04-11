if type rbenv &> /dev/null; then
  local RBENV_SHIMS="${RBENV_ROOT:-$HOME/.rbenv}/shims"
  export PATH="$RBENV_SHIMS:$PATH"
  function rbenv() {
    unset -f rbenv &> /dev/null
    eval "$(command rbenv init -)"
    rbenv "$@"
  }
fi

