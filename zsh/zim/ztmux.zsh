# return if tmux not installed
if (( ! $+commands[tmux] )); then
  return 1
fi

# check if using iTerm
if [[ "$TERM_PROGRAM" = 'iTerm.app' ]]; then
  _tmux_iterm_integration='-CC'
fi

# autostart tmux without first creating an unused session
if [[ -z "$TMUX" ]]; then # TODO: check if -z $EMACS && -z $VIM is needed
  tmux start-server

  # Create a session named 'zmux' if no session has been defined in tmux.conf
  if ! tmux has-session 2> /dev/null; then
    tmux_session='zmux'
      tmux \
      new-session -d -s "$tmux_session" \; \
      set-option -t "$tmux_session" destroy-unattached off &> /dev/null
  fi

  # attach to the session named 'zmux' or to the last session used.
  exec tmux $_tmux_iterm_integration attach-session
fi

# TODO: check if this implementation works, may need to put at end of /root/.zshrc
# if [[ -z "$TMUX" ]]
# then
#     ID="`tmux ls | grep -vm1 attached | cut -d: -f1`"
#     if [[ -z "$ID" ]]
#     then
#         tmux new-session
#     else
#         tmux attach-session -t "$ID"
#     fi
# fi

