#!/bin/zsh

#
# Defines tmux aliases and provides for auto launching it at start-up.
# Source: https://github.com/sorin-ionescu/prezto/blob/master/modules/tmux/init.zsh
#

# Return if requirements are not found.
if (( ! $+commands[tmux] )); then
  return 1
fi

#
# Auto Start
#

if [[ "$TERM_PROGRAM" == 'iTerm.app' ]]; then
  tmux_iterm_integration='-CC'
fi

if [[ -z "$TMUX" && -z "$EMACS" && -z "$VIM" ]]; then
  tmux start-server

  # Create a 'zim' session if no session has been defined in tmux.conf.
  if ! tmux has-session 2> /dev/null; then
    tmux_session='zim'
    tmux \
      new-session -d -s "$tmux_session" \; \
      set-option -t "$tmux_session" destroy-unattached on &> /dev/null
  fi

  # TODO: start tmux with -2 option to support 256 colors
  # Attach to the 'zim' session or to the last session used.
  exec tmux $tmux_iterm_integration attach -d # use: attach vs attach-session
fi
