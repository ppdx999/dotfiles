#!/bin/bash

if [[ -f "$HOME/.cargo/bin/fnm" ]]; then
  eval "$($HOME/.cargo/bin/fnm env --use-on-cd)"
fi
