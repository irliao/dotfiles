# Tmux Configurations 

# Life-cycle: servers contains sessions contains windows(tabs) contains panes(splits)
# Window commands: next-window, previous-window, last-window, select-window -t :0-9 # prefix + 0-9
# Pane commands: select-pane -t :.+, select-pane -t :.-, next-pane, previous-pane, last-pane

# Default Tmux aliases
# bind = bind-key
# set = set-option
# setw = set-window-option
# show = show-option
# showw = show-window-option

# TODO: cleanup unbind keys
# Unbinded Keys
unbind ^s
unbind -t vi-copy q
unbind -t vi-copy v
unbind -t vi-copy y
unbind -t vi-copy Enter
unbind -t vi-copy Escape
unbind Left
unbind Down
unbind Up
unbind Right
unbind A
unbind a
unbind B
unbind b
unbind c
unbind e
unbind n
unbind t
unbind }
unbind {
unbind T
unbind w
unbind d
unbind D
unbind ]
unbind [
unbind x
unbind i
unbind h
unbind j
unbind k
unbind l
unbind H
unbind J
unbind K
unbind L
unbind r
unbind p
unbind v
unbind u
unbind M
unbind m
unbind O
unbind o
unbind s
unbind S
unbind R
unbind Q
unbind Escape
unbind Space
unbind Tab
unbind BTab # Shift + Tab
unbind `

# Prefix set to ^s, holding ^ after prefix to execute more binded keys
unbind C-b
set -g prefix C-s
# bind-key C-s send-prefix

# Vim-style copy/paste
setw -g mode-keys vi # use h, j, k, and l to move around our buffer
set-option -g default-command "reattach-to-user-namespace -l zsh"
bind v copy-mode \; send-keys v # run Vim visual highlight right away
bind -t vi-copy v begin-selection
bind -t vi-copy y copy-pipe "reattach-to-user-namespace pbcopy"
bind -t vi-copy Enter copy-pipe "reattach-to-user-namespace pbcopy"
bind -t vi-copy Escape clear-selection
bind -t vi-copy ` cancel # exit copy-mode
# bind ] run "reattach-to-user-namespace pbpaste | tmux load-buffer - && tmux paste-buffer"

# Navigation
bind -t vi-edit Up   history-up
bind -t vi-edit Down history-down
bind a last-pane \; refresh-client -S # switch pane
bind Tab last-window \; refresh-client -S # used to switch out of Vim pane to Tmux pane

# Window/Pane managements
bind M setw synchronize-panes \; display 'synchronize-panes toggled: #{?pane_synchronized, on, off} ' # toggle Mirroring (sync) pane
bind m command-prompt 'rename-window %%' # edit tab name
bind t new-window # new tab
bind T new-window -c "#{pane_current_path}"
bind b break-pane # make current pane a new window
bind w kill-pane
bind q kill-window 
bind Q kill-server
bind s split-window -h # split into left/right pane
bind S split-window -v # split into top/bottom pane
bind / list-window

# Pane switching
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Pane resizing
bind -rn ^Left resize-pane -L
bind -rn ^Down resize-pane -D
bind -rn ^Up resize-pane -U
bind -rn ^Right resize-pane -R
bind -r Left resize-pane -L 10
bind -r Down resize-pane -D 10
bind -r Up resize-pane -U 10
bind -r Right resize-pane -R 10

# Allow copy to Mac OSX pasteboard using yank with mouse highlight
bind -n WheelUpPane copy-mode
if -b 'which -s reattach-to-user-namespace' 'bind y run "tmux save-buffer - | reattach-to-user-namespace pbcopy"'
# if -b 'which -s reattach-to-user-namespace' 'bind p run "reattach-to-user-namespace pbpaste | tmux load-buffer - && tmux paste-buffer"'
bind C-v run "tmux set-buffer \"$(xsel -ob)\"; tmux paste-buffer" # move x clipboard into tmux paste buffer
bind C-c run "tmux show-buffer | xsel -ib" # move tmux copy buffer into x clipboard

# Other shortcuts
bind r source-file ~/.tmux.conf \; display 'Reloaded tmux.conf'
bind R refresh-client -S
bind Q kill-server
bind u capture-pane \; save-buffer /tmp/tmux-buffer \; split-window -l 10 "urlview /tmp/tmux-buffer" # present menu of URLs to open at pane
bind \; command-prompt

# TODO: bind to better keys
# New window using current shell path
bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"

# TODO: understand what this does... key conflict with ] to pbpaste
# bind ] new-window -d -n tmp \; swap-pane -s tmp.1 \; select-window -t tmp
# bind [ last-window \; swap-pane -s tmp.1 \; kill-window -t tmp
# bind S command-prompt "switch -t %1"

# General options
set -g escape-time 0 # turn ESC-wait off for VI and scroll-buffer access
set -g history-limit 20000 # needed to allow mouse to scroll up
set -g default-terminal screen-256color # DO NOT use xterm-256color... crashes shell display
set -g default-command "reattach-to-user-namespace -l $SHELL" # enable pbcopy, pbpaste, etc
set -g default-command "/bin/bash -c 'which reattach-to-user-namespace >/dev/null && \
							   exec reattach-to-user-namespace $SHELL -l || exec $SHELL -l'" # enable native Mac OS X copy/paste
set -g mouse on # allow mouse click
set -g status-key vi
set -g repeat-time 0
set -g base-index 1
set -g pane-base-index 1
set -g focus-events on # TODO: research focus-events
setw -g aggressive-resize on

# Appearance options
# window title
set -g set-titles on
set -g set-titles-string '#H:#S.#I.#P #W #T' # window number,program name, active(or not)
set -g display-time 1000 # display for 1.0 sec
set -g renumber-windows on # renumber windows after closing any window
set -g allow-rename off # disable auto-rename

# enable activity alerts
setw -g monitor-activity on
set -g visual-activity on

# clock
setw -g clock-mode-colour green #green
setw -g clock-mode-style 24

# messages
setw -g mode-bg magenta
setw -g mode-fg black
set -g message-bg magenta
set -g message-fg black

# status bar
set -g status-utf8 on
set -g status-interval 5 # update every 5 seconds
set -g status-justify centre           # center window list for clarity
# set-option -g status-position top    # position the status bar at top of screen

# default statusbar colors
set -g status-bg black #base2
set -g status-fg yellow #yellow
set -g status-attr default

# show host name and IP address on left side of status bar
# to show $PWD -> #[fg=blue]#{pane_current_path}
set -g status-left-length 70
set -g status-left "#[fg=green]#h#[fg=white]::#[fg=yellow]#(ifconfig en0 | grep 'inet ' | awk '{print \"en0:\" $2}')#(ifconfig en1 | grep 'inet ' | awk '{print \"en1 \" $2}')::#[fg=blue]#S#I:#P::#{prefix_highlight}"

# show session name #S, window number #I, pane number #P, date, time, battery percentage/time remaining
set -g status-right-length 70
set -g status-right "#[fg=yellow]%b-%d-%Y#[fg=white]::#[fg=green]%l:%M%p#[fg=white]::#[fg=red]#{battery_remain}::#[fg=blue]#{battery_percentage}"

# default window colors
setw -g window-status-fg brightyellow #base00
setw -g window-status-bg default
setw -g window-status-attr dim

# window colors
setw -g window-status-current-fg brightred #orange
setw -g window-status-current-bg default
setw -g window-status-current-attr bright

# pane border
set -g pane-border-fg white #base2
set -g pane-active-border-fg brightcyan #base1

# message text
set -g message-bg black #base2
set -g message-fg brightred #orange

# pane number display
set -g display-panes-time 800 # display for 0.8 sec
set -g display-panes-active-colour blue #blue
set -g display-panes-colour brightred #orange

# border coloring for panes
set -g pane-active-border-fg green

# Override keys binded by Plugins
set -g @sidebar-tree 'b' # default is 'Tab'
set -g @sidebar-tree-focus 'B' # default is 'Delete'
set -g @open 'o' # default is 'o'
set -g @open-editor 'e' # default is Ctrl-o

# Plugins: https://github.com/tmux-plugins/tpm (should be at bottom of tmux.conf)
# default binded keys: Prefix + I - install, Prefix + U - update
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-copycat'
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'tmux-plugins/tmux-open'
set -g @plugin 'tmux-plugins/tmux-battery'
set -g @plugin 'tmux-plugins/tmux-prefix-highlight'
set -g @plugin 'tmux-plugins/tmux-sidebar'
set -g @plugin 'seebi/tmux-colors-solarized'

# install tpm automatically when tmux is started
if "test ! -d ~/.tmux/plugins/tpm" \
   "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm'"

# initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm' 

# EOF
