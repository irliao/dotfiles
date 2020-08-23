# Tmux utilities

# TODO: set Tmux aliases if using Terminal
# Tmux
alias tmx='TERM=xterm-256color tmx'
alias tmux='TERM=xterm-256color \tmux'
alias tmk="tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill"
alias tmk="tmux kill-server"
alias tmu="tmux source-file ~/.tmux.conf"
alias getTmuxLayout='tmux list-windows -F "#{window_active} #{window_layout}" | grep "^1" | cut -d " " -f 2'
alias tlc="source ~/.tmux/tmux_colors.sh"
alias tclear="run_in_all_naked_panes clear" # requires script in ~/.bin
# NOTE: show tmux binded keys with: tmux list-keys -t vi-copy

