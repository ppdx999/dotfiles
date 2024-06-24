#!/usr/bin/env bash

set -ue

export DEBIAN_FRONTEND=noninteractive

dot_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

$dot_dir/install/basic.sh
$dot_dir/install/tmux.sh
$dot_dir/install/link.sh
$dot_dir/install/rust.sh
$dot_dir/install/go.sh
$dot_dir/install/lazygit.sh
$dot_dir/install/deno.sh
$dot_dir/install/nvim.sh
$dot_dir/install/fnm.sh
$dot_dir/install/starship.sh
$dot_dir/install/python.sh
$dot_dir/install/ripgrep.sh
# $dot_dir/install/lvim.sh
$dot_dir/install/pnpm.sh
$dot_dir/install/pyenv.sh
command echo -e "\e[1;36m Install completed!!!! \e[m"
