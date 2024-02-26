#!/bin/bash
set -eu

wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -zxvf nvim-linux64.tar.gz
mv nvim-linux64/bin/nvim /usr/bin/nvim
mv nvim-linux64/lib/nvim /usr/lib/nvim
mv nvim-linux64/share/nvim/ /usr/share/nvim
rm -rf nvim-linux64
rm nvim-linux64.tar.gz
