#!/bin/bash
set -eu

sudo rm -rf /usr/bin/nvim
sudo rm -rf /usr/lib/nvim
sudo rm -rf /usr/share/nvim

wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
tar -zxvf nvim-linux-x86_64.tar.gz
sudo mv nvim-linux-x86_64/bin/nvim /usr/bin/nvim
sudo mv nvim-linux-x86_64/lib/nvim /usr/lib/nvim
sudo mv nvim-linux-x86_64/share/nvim/ /usr/share/nvim
rm -rf nvim-linux-x86_64
rm nvim-linux-x86_64.tar.gz
