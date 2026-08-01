#!/usr/bin/env bash

set -euo pipefail

error() {
  printf '\e[1;31mERROR:\e[m %s\n' "$*" >&2
  exit 1
}

platform=$(uname -s)
if [[ "$platform" == Linux ]]; then
  # shellcheck disable=SC1091
  . /etc/os-release
  platform=$ID
fi

case "$platform" in
  Darwin)
    if ! command -v git > /dev/null 2>&1; then
      error 'Install the Xcode Command Line Tools then rerun this.'
    fi
    ;;
  debian)
    if ! command -v git > /dev/null 2>&1; then
      sudo apt update
      sudo apt install -y git
    fi
    ;;
  *)
    error "Unsupported platform: $platform"
    ;;
esac

dir="$HOME/dotfiles"
if [[ -e "$dir" && ! -d "$dir/.git" ]]; then
  error "Existing path is not a Git repository: $dir"
fi

if [[ ! -e "$dir" ]]; then
  git clone --filter=blob:none https://github.com/fei6409/dotfiles.git "$dir"
fi

cd "$dir"
git remote set-url --push origin git@github.com:fei6409/dotfiles.git
./bootstrap
