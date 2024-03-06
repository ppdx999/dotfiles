#!/bin/bash
set -eu

if [ ! -d "$HOME/.pyenv" ]; then
  curl https://pyenv.run | bash
fi
