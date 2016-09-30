#!/usr/bin/tmux source-file

# Start three horizontally split panes. Useful for new sessions in TotalTerminal.
# To use in TotalTerminal, edit the Visor Terminal.app profile, and set the command to:
#
#   /usr/local/bin/tmux start-server; source-file ~/.tmux/visor.sh
#
# Uncheck "Run inside shell" for faster bootup

# Start new session detached
new-session -d

# split-window -t 0 -h          # split first pane into two
# split-window -t 1 -h          # split second pane into two
# select-pane -t 0              # select first pane
# select-layout even-horizontal # even out

# Attach to new session
attach
