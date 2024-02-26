#!/usr/bin/env bash

set -ue

dot_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

$dot_dir/install/basic.sh
$dot_dir/install/link.sh
$dot_dir/install/rust.sh
$dot_dir/install/go.sh
$dot_dir/install/lazygit.sh
$dot_dir/install/deno.sh
command echo -e "\e[1;36m Install completed!!!! \e[m"
