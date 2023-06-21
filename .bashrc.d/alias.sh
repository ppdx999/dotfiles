alias nv='nvim'
alias cdw='cd ~/workspace/dc3mp'

alias venv='source venv/bin/activate'

function git_fetch_pr() {
 command git fetch origin pull/$1/head:PR-$1
}
