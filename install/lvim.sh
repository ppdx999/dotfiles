#!/bin/bash
set -eu

if [ ! -f "$HOME/.local/bin/lvim" ]; then
  LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh | sed -e 's;cargo install;$HOME/.cargo/bin/cargo install;' -e 's;-v cargo;-v $HOME/.cargo/bin/cargo;' ) -- -y
fi
