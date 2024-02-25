#!/usr/bin/env bash
set -ue

link_to_homedir() {
  command echo "backup old dotfiles..."
  if [ ! -d "$HOME/.dotbackup" ];then
    command echo "$HOME/.dotbackup not found. Auto Make it"
    command mkdir "$HOME/.dotbackup"
  fi

  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  local dotdir=$(dirname ${script_dir})
  if [[ "$HOME" != "$dotdir" ]];then
    for f in $dotdir/.??*; do
      [[ `basename $f` == ".git" ]] && continue

      # If the file is symbolic link, unlink it.
      [[ -L "$HOME/`basename $f`" ]] && command unlink "$HOME/`basename $f`"

      # If the file is exist, backup it.
      [[ -e "$HOME/`basename $f`" ]] && command mv "$HOME/`basename $f`" "$HOME/.dotbackup"

      # make symlink
      command ln -snf $f $HOME
    done
  else
    command echo "same install src dest"
  fi
}

while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      command echo "Usage: $0 [--help | -h]" 0>&2
      command echo ""
      exit 1
      ;;
    *)
      ;;
  esac
  shift
done

link_to_homedir
command echo -e "\e[1;36m Install completed!!!! \e[m"
