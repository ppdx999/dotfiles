#!/bin/bash
set -eu

sudo rm -rf /usr/bin/nvim
sudo rm -rf /usr/lib/nvim
sudo rm -rf /usr/share/nvim

wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -zxvf nvim-linux64.tar.gz
sudo mv nvim-linux64/bin/nvim /usr/bin/nvim
sudo mv nvim-linux64/lib/nvim /usr/lib/nvim
sudo mv nvim-linux64/share/nvim/ /usr/share/nvim
rm -rf nvim-linux64
rm nvim-linux64.tar.gz
