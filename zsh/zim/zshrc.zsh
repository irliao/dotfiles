#
# User configuration sourced by interactive shells
#

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

skip_global_compinit=1 # faster Zsh startup
DEFAULT_USER="irliao" # replaces user@hostname with specified username

# Environment variables
export ICLOUD="${HOME}/Library/Mobile Documents/com~apple~CloudDocs/"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export EDITOR='vim'

# Specify your defaults in this environment variable
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/opt/homebrew-cask/Caskroom"

# Overload system default 256-color palette with precise gruvbox colors
if [[ -f "${HOME}/.vim/bundle/gruvbox/gruvbox_256palette.sh" ]]; then
	source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
fi

# Custom rc 
if [[ -f "${ZDOTDIR:-$HOME}/.bashrc" ]]; then
    source "${ZDOTDIR:-$HOME}/.bashrc"
fi

# Custom functions
if [[ -f "${ZDOTDIR:-$HOME}/.zfunction" ]]; then
    source "${ZDOTDIR:-$HOME}/.zfunction"
fi

# Source aliases last for function scope, -f lets the expression to be true if arg is file
if [[ -f "${ZDOTDIR:-$HOME}/.zalias" ]]; then
    source "${ZDOTDIR:-$HOME}/.zalias"
fi

# Auto start Tmux 
if [[ -f "${ZDOTDIR:-$HOME}/.ztmux" ]]; then
    source "${ZDOTDIR:-$HOME}/.ztmux"
fi

# Vim-style editing
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey "^H" beginning-of-history

# NVM for Node
export NVM_DIR="/Users/irliao/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# EOF
