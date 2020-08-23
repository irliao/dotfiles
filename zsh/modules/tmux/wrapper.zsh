# Tmux wrapper

# NOTE: source this file before sourcing zim/init.zsh

# Return if requirements are not found.
# if (( ! $+commands[tmux] )); then
#   return 1
# fi

# tm() {
#     # Tmux attach or create new session
#     if tmux ls &>/dev/null; then
#         echo "Tmux session is already exists. Use it? [y/N]:"
#         read -q && echo && tmux attach && return
#     fi
#     tmux new
# }

# Start tmux on login
#if [[ -o login && -z "$TMUX" ]]; then
#    tmux -V &>/dev/null && exec tm
#fi

