#!/bin/zsh

# Runs the specified command (provided by the first argument) in all tmux panes.
#
# - Checks if a shell is running in the pane
# - Checks if in that shell, another process is not already running
#
# Does not run the command if another command is already running.
#
# Usage:
#
#   run_in_all_naked_panes clear
#
# Recommended:
#
#    alias tclear="run_in_all_naked_panes clear"
#

function run_in_all_naked_panes {

  # Checks if a process is already running in the shell
  # first arg is pane ID, second arg is PID, third arg is command
  function run_if_naked_shell {

    # Returns PID of a child process, or empty if none
    if [[ -z $(pgrep -P $2) ]]
    then
      tmux send-keys -t $1 " $3" C-m # C-m is carriage return
    fi

  }

  # Assign the argument to something readable
  command=$1

  # If we're in a Tmux pane
  if [[ -n $TMUX_PANE ]]
  then
    # Note which pane we were originally at
    original_pane=$(tmux display-message -p '#P')

    # Run in this pane too
    $command
  fi

  # Loop through the panes that are in the window
  tmux list-panes -F '#{pane_index}:#{pane_pid}' | while IFS=':' read pane pid; do
    # Don't run the command in the current pane if we are in a Tmux pane,
    # because we would've run the command already above.
    if [[ $original_pane != $pane ]]; then
      run_if_naked_shell $pane $pid $command
    fi
  done

}