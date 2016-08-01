#
# User configuration sourced by interactive shells
#

# . `brew --prefix`/etc/profile.d/z.sh

# Source zim's init.zh, which sources ~/.zimrc, which decides prompt theme
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

# skip_global_compinit=1 # faster Zsh startup
zprompt_theme='mingit' # custom prompt theme
DEFAULT_USER="irliao" # replaces user@hostname with specified username

# Autocompletion
fpath=(~/.dotfiles/zsh/completions $fpath)
autoload -U compinit && compinit

# Environment variables
export PATH="/usr/local/bin:${HOME}/.bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export ICLOUD="${HOME}/Library/Mobile Documents/com~apple~CloudDocs/"
export DEVPATH="${HOME}/Developments"
export EDITOR='vim'
export MUX='mux' # use 'ztmux' for Tmux integration

# Ruby
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Brew
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/opt/homebrew-cask/Caskroom" # install path
export HOMEBREW_NO_ANALYTICS=1 # opt-out of analytics

# Node Version Manager (nvm)
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Cheat
export CHEATCOLORS=true

# The Fuck
eval "$(thefuck --alias)"
# You can use whatever you want as an alias, like for Mondays:
eval "$(thefuck --alias fk)"

# Key bindings matching Mac OSX
bindkey "^A" beginning-of-line
bindkey "^B" beginning-of-line # to use in tmux
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey "^H" beginning-of-history

# Local profile... exports local (or private) variables
if [[ -f "${HOME}/.local_profile" ]]; then
    source "${HOME}/.local_profile";
fi

# Bash profile
if [[ -f "${HOME}/.bash_profile" ]]; then
    source "${HOME}/.bash_profile";
fi


# Custom functions
if [[ -f "${HOME}/.zfunction" ]]; then
    source "${HOME}/.zfunction"
fi

# Custom aliases, should source after custom functions incase aliasing functions
if [[ -f "${HOME}/.zalias" ]]; then
    source "${HOME}/.zalias"
fi

# Support 256 colors
# if [ -e /usr/share/terminfo/x/xterm-256color ]; then
#   export TERM='xterm-256color'
# else
#   export TERM='screen-256color'
# fi

# Auto start Tmux (only when using Zim and default Apple Terminal)
if [[ (-f "${HOME}/.ztmux") && ($TERM_PROGRAM == "Apple_Terminal") ]]; then
  if [[ -f "${HOME}/.iterm2_shell_integration.zsh" ]]; then
    rm "${HOME}/.iterm2_shell_integration.zsh" && echo "removed ~/.iterm2_shell_integration.zsh";
  fi

  # Overload system default 256-color palette with precise gruvbox colors
  # if [[ -f "${HOME}/.vim/gruvbox_256palette_osx.sh" ]]; then
  #   source "${HOME}/.vim/gruvbox_256palette_osx.sh";
  # fi

  # BASE16_SHELL=$HOME/.config/base16-shell/
  # [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

  #source "${HOME}/.ztmux"
else # iTerm2
  # iTerm2 shell integration with unix shell
  if [[ ! -h "${HOME}/.iterm2_shell_integration.zsh" ]]; then # check if file is Symlink
    # Custom shell loading for iTerm
    ln -s ${HOME}/.dotfiles/config/terminal/iterm2_shell_integration.zsh ${HOME}/.iterm2_shell_integration.zsh;
  fi
  # use iterm2_shell_integration.`basename $SHELL` when dealing with multiple shells
  test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh;

  # load Base16 shell... should be the same as iTerm2's Preset to avoid visible color changing
  BASE16_SHELL="$HOME/.dotfiles/term/base16-scripts/base16-default-dark.sh"
  [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

  # integrate iTerm2 with Tmux
  if [[ $MUX = "ztmux" ]]; then
    source "${HOME}/.ztmux"
  fi
fi

# Clears the "Last login" message at startup
clear;

# Unused settings
#
# PATH configured to work with NPM global installs (without sudo)
# NPM_PACKAGES="${HOME}/.node_modules_global"
# NPM_PACKAGES_BIN="${HOME}/.node_modules_global/bin" # include in PATH if setting prefix with .npmrc
# unset MANPATH
# export MANPATH="$NPM_PACKAGES/share/man:$(manpath)" # include manuals from npm modules


