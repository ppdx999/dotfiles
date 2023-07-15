[[ -d "$HOME/.local/bin" ]] && export PATH="$PATH:$HOME/.local/bin"
[[ -d "$HOME/bin"        ]] && export PATH="$PATH:$HOME/bin"

[[ -d "$HOME/.cargo/bin" ]] && export PATH="$PATH:$HOME/.cargo/bin"
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# ghcup-env
[ -f "/home/fujis/.ghcup/env" ] && . "/home/fujis/.ghcup/env"
