#!/bin/bash
set -ue

if [[ -f "$HOME/.cargo/env" ]]; then
  echo "Rust is already installed"
  exit 0
fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
