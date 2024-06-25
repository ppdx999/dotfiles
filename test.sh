#!/bin/bash

set -ue

error_exit () {
  printf 'Error: %s\n' "$1" >&2
  exit 1
}

assert_command_exist() {
  for cmd in "$@"; do
   command -v $cmd &> /dev/null || error_exit "Command $cmd not found"
  done
}

assert_symlink_exist() {
  for f in "$@"; do
    [[ -L $f ]] || error_exit "Symlink $f not found"
  done
}

assert_symlink_exist \
  $HOME/.bashrc \
  $HOME/.tmux.conf \
  $HOME/.config/nvim \
  $HOME/.config/bash
  # $HOME/.config/lvim \

assert_command_exist \
  tmux \
  $HOME/.cargo/bin/cargo \
  /usr/bin/go \
  /usr/local/bin/lazygit \
  $HOME/.deno/bin/deno \
  nvim \
  $HOME/.cargo/bin/fnm \
  $HOME/.cargo/bin/starship \
	python3 \
	pip3 \
  rg \
  $HOME/.local/bin/lvim \
  $HOME/.local/share/pnpm/pnpm \
  $HOME/.pyenv/bin/pyenv
