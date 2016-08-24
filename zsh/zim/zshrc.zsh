#
# User configuration sourced by interactive shells
#

# Source zim's init.zh, which sources ~/.zimrc, which decides prompt theme
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

skip_global_compinit=1 # faster Zsh startup
zprompt_theme='mingit' # custom prompt theme
DEFAULT_USER="irliao" # replaces user@hostname with specified username

# Environment variables
export PATH="/usr/local/bin:${HOME}/.bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export EDITOR='vim'
export DEVPATH="${HOME}/Developments"

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
eval "$(thefuck --alias fk)"

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/(vicmd|opp)/$VIM_PROMPT}/(main|viins)/}"
    # RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $(git_custom_status) $EPS1"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1 # 0.4 to 0.1 sec delay in Vim mode display change, raise value if other commands getting issues

# Ambiguous completion will insert first match instead of listing other possibilities or beeping
setopt MENU_COMPLETE

# Local profile... exports local (or private) variables
[[ -f "${HOME}/.local_profile" ]] && source "${HOME}/.local_profile"

# Bash profile
[[ -f "${HOME}/.bash_profile" ]] && source "${HOME}/.bash_profile"

# Custom functions
[[ -f "${HOME}/.zfunction" ]] && source "${HOME}/.zfunction"

# Custom aliases, should source after custom functions incase aliasing functions
[[ -f "${HOME}/.zalias" ]] && source "${HOME}/.zalias"

# Use 256 color terminal
# export TERM=xterm-256color

# Load colorscheme... match Terminal/iTerm2 color profile for precise theme display
BASE16_SHELL="$HOME/.dotfiles/term/base16-default-dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Term specific customizations
if [[ ($TERM_PROGRAM == "Apple_Terminal") ]]; then # Apple Terminal
  if [[ -h "${HOME}/.iterm2_shell_integration.zsh" ]]; then
    rm "${HOME}/.iterm2_shell_integration.zsh" && echo "removed ~/.iterm2_shell_integration.zsh";
  fi

  # Key bindings
  bindkey -v
  bindkey "^A" beginning-of-line
  bindkey "^E" end-of-line
  bindkey "^K" kill-line
  bindkey '^Z' up-history
  bindkey "^H" beginning-of-history
  bindkey "^R" history-incremental-search-backward
  bindkey "^P" history-search-backward
  bindkey "^Y" accept-and-hold
  bindkey "^N" insert-last-word
  bindkey '^X' down-history

  test -e $HOME/.ztmux && source $HOME/.ztmux
else # iTerm2
  # iTerm2 shell integration with Unix shell
  if [[ ! -h "${HOME}/.iterm2_shell_integration.zsh" ]]; then # check if file is Symlink
    # Custom shell loading for iTerm
    ln -s ${HOME}/.dotfiles/config/terminal/iterm2_shell_integration.zsh ${HOME}/.iterm2_shell_integration.zsh;
  fi

  # Rename title displayed from tabs in iTerm
  function title () {
    if [[ $# == 0 ]] then
      echo -ne "\e]1;$PWD\a"
    else
      echo -ne "\e]1;$@\a"
    fi
  }

  # use iterm2_shell_integration.`basename $SHELL` when dealing with multiple shells
  test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh;
fi

# Clears the "Last login" message at startup
clear;

# Unused settings
#

# Autocompletion
# fpath=(~/.dotfiles/zsh/completions $fpath)
# autoload -U compinit && compinit

# PATH configured to work with NPM global installs (without sudo)
# NPM_PACKAGES="${HOME}/.node_modules_global"
# NPM_PACKAGES_BIN="${HOME}/.node_modules_global/bin" # include in PATH if setting prefix with .npmrc
# unset MANPATH
# export MANPATH="$NPM_PACKAGES/share/man:$(manpath)" # include manuals from npm modules
#

