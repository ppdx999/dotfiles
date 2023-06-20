[[ -d "$HOME/.local/bin" ]] && export PATH="$PATH:$HOME/.local/bin"
[[ -d "$HOME/bin"        ]] && export PATH="$PATH:$HOME/bin"

. "$HOME/.cargo/env"
