# Tmux integration with Zsh

# Original: https://github.com/sorin-ionescu/prezto/blob/master/modules/tmux/init.zsh

# return if tmux not installed
if (( ! $+commands[tmux] )); then
  return 1
fi

if [[ "$TERM_PROGRAM" = 'iTerm.app' ]]; then
  _tmux_iterm_integration='-CC'
fi

# echo "start of script: tty: $(tty)"
# echo "login shell: $SHELL"
# autostart tmux without first creating an unused session
# if [[ -z "$TMUX" && -z "$EMACS" && -z "$VIM" ]]; then
if [[ -z "$TMUX" && -z "$EMACS" && -z "$VIM" ]] && ( \
  ( [[ -n "$SSH_TTY" ]] ) || ( [[ -z "$SSH_TTY" ]] ) \
); then
  tmux start-server # tmux first loads /etc/tmux.conf, then loads ~/.tmux.conf
  # echo "after start server: tty: $(tty)"
  # Create a session named 'zmux' if no session has been defined in tmux.conf
  if ! tmux has-session 2> /dev/null; then
    tmux_session='zmux'
    tmux \
    new-session -d -s "$tmux_session" \; \
    set-option -t "$tmux_session" destroy-unattached off &> /dev/null
  fi

  # attach to zmux session or to the last session used
  exec tmux $_tmux_iterm_integration attach-session
  # exec tmux $_tmux_iterm_integration attach -d
  # exec tmux attach-session -d
fi

alias tmuxa="tmux $_tmux_iterm_integration new-session -A"
alias tmuxl='tmux list-sessions'