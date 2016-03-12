#
# Executes commands at the start of an interactive session.
#

# Main user configuration file, will be sourced when starting as a interactive shell.
# It should contain commands to set up aliases, functions, options, key bindings, etc.
# Depends on modules: https://github.com/sorin-ionescu/prezto/tree/master/modules

# Source Prezto, -s lets the expression to be true if file has non-zero size
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# History settings - prezto/modules/history
HISTFILE="${HOME}/.zhistory"
HISTSIZE=10000000				# current session history size
SAVEHIST=$HISTSIZE				# saved history size, needed to save history
setopt append_history           
setopt hist_reduce_blanks       # remove superfluous blanks before recording entry
setopt hist_verify              # show before executing history commands
setopt share_history            # share hist between sessions
setopt hist_verify               # don't execute immediately upon history expansion
setopt hist_ignore_dups          # don't record an entry that was just recorded again
unsetopt hist_ignore_space      # ignore space prefixed commands

# Unix settings
setopt rmstarsilent # "rm" command without confirmation, rm overwritten in zfunction.zsh

# Key bindings - prezto/modules/editor
# Vi binded
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode
bindkey -M viins 'jj' vi-cmd-mode

# Edit binded
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey "^H" beginning-of-history

# Functions binded
bindkey -s '^D' '^qclear\n' # -s to bind to command, ^q to ensure buffer is empty, must be single quote
bindkey -s '^W' '^qexit\n'
bindkey -s '^Z' '^qzsync\n'
bindkey -s '^T' '^qtoggleShowAllFilesInFinder\n'
# bindkey -s "^T" "^[Isudo ^[A" # type "sudo"

# Source aliases last for function scope, -f lets the expression to be true if arg is file
if [[ -f "${ZDOTDIR:-$HOME}/.zfunction" ]]; then
    source "${ZDOTDIR:-$HOME}/.zfunction"
fi

# Source aliases last for function scope, -f lets the expression to be true if arg is file
if [[ -f "${ZDOTDIR:-$HOME}/.zalias" ]]; then
    source "${ZDOTDIR:-$HOME}/.zalias"
fi

# Source bash_profile (optional), which should source bashrc (bashrc should be local to each user)
if [[ -f "${HOME}/.bash_profile" ]]; then
    source "${HOME}/.bash_profile"
fi

# Overload system default 256-color palette with precise gruvbox colors
if [[ -f "${HOME}/.vim/bundle/gruvbox/gruvbox_256palette.sh" ]]; then
	source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
fi

# Node Version Manager (NVM)
export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Timing app needs this to track folders
# usually do this in ~/.zprofile, with Terminal formatted "user@mac:/your/working/directory"
# PROMPT_TITLE='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
# export PROMPT_COMMAND="${PROMPT_COMMAND} ${PROMPT_TITLE}; "

# History settings
# setopt inc_append_history       # write to the history file immediately, not when the shell exits
# setopt bang_hist                # treat the '!' character specially during expansion
# setopt hist_ignore_all_dups     # delete old recorded entry if new entry is a duplicate
# setopt HIST_FIND_NO_DUPS         # do not display a line previously found
# setopt HIST_SAVE_NO_DUPS         # don't write duplicate entries in the history file
# setopt HIST_BEEP                 # Beep when accessing nonexistent history.
# unset HISTFILE				  # disable shell history saving

# EOF
