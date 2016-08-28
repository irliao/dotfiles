# return if tmux not installed
if (( ! $+commands[tmux] )); then
  return 1
fi

if ([[ "$TERM_PROGRAM" = 'iTerm.app' ]]); then
  _tmux_iterm_integration='-CC'
fi

# echo "start of script: tty: $(tty)"
# echo "login shell: $SHELL"
# autostart tmux without first creating an unused session
# if [[ -z "$TMUX" && -z "$EMACS" && -z "$VIM" && ( [[ -n "$SSH_TTY"]] || [[ -z "$SSH_TTY" ]] ) ]]; then # TODO: check if -z $EMACS && -z $VIM is needed
if [[ -z "$TMUX" ]]; then
  tmux start-server
  # echo "after start server: tty: $(tty)"
  # Create a session named 'zmux' if no session has been defined in tmux.conf
  if ! tmux has-session 2> /dev/null; then
    tmux_session='zmux'
      tmux \
        new-session -d -s "$tmux_session" \; \
        set-option -t "$tmux_session" destroy-unattached off &> /dev/null
  fi

  exec tmux $_tmux_iterm_integration attach-session
fi

# exec bash -c 'shopt -sq checkwinsize'

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

