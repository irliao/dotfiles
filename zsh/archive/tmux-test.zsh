# return if tmux not installed
# if (( ! $+commands[tmux] )); then
#   return 1
# fi


# autostart tmux without first creating an unused session
# if [[ -z "$TMUX" && -z "EMACS" && -z "$VIM" && ( [[ -n "$SSH_TTY"]] || [[ -z "$SSH_TTY" ]] ) ]]; then # TODO: check if -z $EMACS && -z $VIM is needed
if [[ -z "$TMUX" ]]; then
  tmux start-server # start server without creating new session
  tmux_session='ztmux'
  # Create a session named 'ztmux' if no session has been defined in tmux.conf
  if ! tmux has-session 2> /dev/null; then
      tmux attach -t "$tmux_session" || new -s "$tmux_session" \; \
        set-option -t "$tmux_session" destroy-unattached off &> /dev/null
        exit 0
  fi

  # attach to the session named 'zmux' or to the last session used.
  exec tmux attach -t "$tmux_session"
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

