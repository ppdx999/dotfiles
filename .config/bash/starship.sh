#!/bin/bash

if [ -f $HOME/.cargo/bin/starship ]; then
	eval "$($HOME/.cargo/bin/starship init bash)"
fi
