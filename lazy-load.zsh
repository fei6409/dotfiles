# https://github.com/rbenv/rbenv
export RBENV_ROOT="$HOME/.rbenv"
if if_has rbenv; then
    # It's recommended to prepend shim path over append.
    export PATH="$RBENV_ROOT/shims:$PATH"
    function rbenv() {
        unset -f rbenv &>/dev/null
        eval "$(command rbenv init -)"
        rbenv "$@"
    }
fi

# https://github.com/pyenv/pyenv
export PYENV_ROOT="$HOME/.pyenv"
if_has pyenv || export PATH="$PYENV_ROOT/bin:$PATH"
if if_has pyenv; then
    # It's recommended to prepend shim path over append.
    export PATH="$PYENV_ROOT/shims:$PATH"
    function pyenv() {
        unset -f pyenv &>/dev/null
        eval "$(command pyenv init -)"
        pyenv "$@"
    }
fi
