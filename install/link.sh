#!/usr/bin/env bash
set -ue

error_exit () {
  printf '%s\n' "$1" >&2
  exit 1
}

backup_and_link() {
  local src_file=$1
  local dest_dir=$2
  local backup_dir=$3
  local dest_file="$dest_dir/$(basename "$src_file")"

  # If the file is symbolic link, unlink it.
  [[ -L "$dest_file" ]] && command unlink "$dest_file"

  # If the file is exist, backup it.
  [[ -e "$dest_file" ]] && command mv "$dest_file" "$backup_dir"

  command ln -snf "$src_file" "$dest_dir"
}

link_config_dir() {
  local dot_dir=$1
  local backup_dir="${2}/.config"
  local dest_dir="${HOME}/.config" # ${XDG_CONFIG_HOME}

  [[ -d "$backup_dir" ]] || mkdir -p "$backup_dir"
  [[ -d "$dest_dir" ]] || mkdir -p "$dest_dir"

  for f in "$dot_dir"/.config/??*; do
    backup_and_link "$f" "$dest_dir" "$backup_dir"
  done
}

link_to_home_dir() {
  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  local dot_dir=$(dirname $script_dir)
  local backup_dir="${XDG_CACHE_HOME:-$HOME/.cache}/dotbackup/$(date '+%y%m%d-%H%M%S')"

  [[ -d "backup_dir" ]] || command mkdir -p "$backup_dir"
  
  [[ "$HOME" == "$dot_dir" ]] && error_exit "src_dir and dest_dir are the same"
  
  mapfile -t linkignore <"$dot_dir/.linkignore"
  for f in $dot_dir/.??*; do
    local f_filename=$(basename "$f")
    [[ ${linkignore[*]} =~ $f_filename ]] && continue
    [[ "$f_filename" == ".config" ]] && link_config_dir "$dot_dir" "$backup_dir" && continue
    backup_and_link "$f" "$HOME" "$backup_dir"
  done
}

link_to_home_dir
