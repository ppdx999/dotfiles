#!/bin/bash

if [[ -d "$HOME/go/bin" ]]; then
  export PATH="$HOME/go/bin:$PATH"
fi

if [[ -d "/usr/local/go" ]]; then
  export PATH="/usr/local/go/bin:$PATH"
fi
