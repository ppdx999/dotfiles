#!/bin/bash
set -eu

$HOME/.cargo/bin/cargo install fnm

if [[ -f "$HOME/.cargo/bin/fnm" ]]; then
  eval "$($HOME/.cargo/bin/fnm env --use-on-cd)"

  if [[ $($HOME/.cargo/bin/fnm current) = "none" ]]; then
    $HOME/.cargo/bin/fnm install --lts
  fi
fi
