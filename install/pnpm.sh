#!/bin/bash
set -eu

if [ ! -d "$HOME/.local/share/pnpm" ]; then
  wget -qO- https://get.pnpm.io/install.sh | ENV="$HOME/.bashrc" SHELL="$(which bash)" bash -
fi
