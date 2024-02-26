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
  $HOME/.config/lvim

assert_command_exist \
  $HOME/.cargo/bin/cargo \
  /usr/bin/go
