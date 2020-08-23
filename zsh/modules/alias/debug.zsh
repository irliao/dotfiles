# Debug utilities

alias isLoginShell="if [[ -o login ]]; then; print yes; else; print no; fi"
alias fixvim="rm ~/.zcompdump* && compinit"
alias printTmuxPaneSize='tmux list-panes -F "#{pane_width}x#{pane_height}"' # desired window size: x=204, y=64
alias printTmuxCopyModeKeys='tmux list-keys -t vi-copy'
alias printTmuxOptions='tmux show-options -g'
alias enableAutoTmux="ln -s ~/.dotfiles/zsh/zim/ztmux.zsh ~/.ztmux"
alias disableAutoTmux="rm ~/.ztmux && killall tmux"
alias printTmuxColors="source ~/.bin/tmux_colors.sh"
alias printTTYs="ps -a"
