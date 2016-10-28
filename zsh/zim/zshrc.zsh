#
# User configuration sourced by interactive shells
#

# Source zim's init.zh, which sources ~/.zimrc, which decides prompt theme
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

# skip_global_compinit=1 # faster Zsh startup
autoload -Uz promptinit
promptinit
prompt mingit

DEFAULT_USER="irliao" # replaces user@hostname with specified username
# LANG=en_US.utf8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Environment variables
typeset -U fpath
typeset -U path
path=(
  /usr/local/{bin,sbin}
  $path
)
typeset -U PATH # remove duplicate entries in Path
export PATH="/usr/local/bin:$HOME/.bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

# TODO: figure out how LESS works
# export LESS_TERMCAP_mb=$'\E[01;31m'
# export LESS_TERMCAP_md=$'\E[01;31m'
# export LESS_TERMCAP_me=$'\E[0m'
# export LESS_TERMCAP_se=$'\E[0m'
# export LESS_TERMCAP_so=$'\E[01;44;33m'
# export LESS_TERMCAP_ue=$'\E[0m'
# export LESS_TERMCAP_us=$'\E[01;32m'
# export LESS="-R"
# export PAGER='less'

export VISUAL='vim'
export EDITOR='vim'
export DEVPATH="$HOME/Developments"
export HISTCONTROL=erasedups  # Ignore duplicate entries in history
export HISTIGNORE="&:ls:ll:la:l.:pwd:exit:clear:clr:[bf]g"

# Brew
fpath=("/usr/local/bin/" $fpath)
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/opt/homebrew-cask/Caskroom" # install path
export HOMEBREW_NO_ANALYTICS=1 # opt-out of analytics

# Go
export GOPATH="$DEVPATH/go"
export PATH="$PATH:$GOPATH/bin"

# Node
# export NVM_DIR="$HOME/.nvm"
# . "$(brew --prefix nvm)/nvm.sh"
# export PATH=~/.npm-global/bin:$PATH

# The Fuck
eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"

# Completion with more than 1 possibilities will insert first available option into prompt automatically
setopt MENU_COMPLETE

# List files upon change directory
function chpwd() {
  emulate -L zsh
  ls
}

# Custom functions
[[ -f "${HOME}/.zfunction" ]] && source "${HOME}/.zfunction"

# Custom aliases, should source after custom functions incase aliasing functions
[[ -f "${HOME}/.zalias" ]] && source "${HOME}/.zalias"

# Local profile... exports local (or private) variables
[[ -f "${HOME}/.local_profile" ]] && source "${HOME}/.local_profile"

# Bash profile
[[ -f "${HOME}/.bash_profile" ]] && source "${HOME}/.bash_profile"

# Autosuggestion
# if [[ ! -d ~/.zsh/zsh-autosuggestions ]]; then
#     git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# fi
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Use 256 color terminal
export TERM="xterm-256color"

# Term specific customizations
if [[ ($TERM_PROGRAM == "Apple_Terminal") ]]; then # Apple Terminal
  if [[ -h "${HOME}/.iterm2_shell_integration.zsh" ]]; then
    rm "${HOME}/.iterm2_shell_integration.zsh" && echo "removed ~/.iterm2_shell_integration.zsh";
  fi

  # Disables ^S (freeze terminal output) and ^Q (resume terminal output)
  unsetopt flowcontrol

  # TODO: bind keys to delete words faster, maybe bind to Option keys (requires research)
  # Key bindings, available widgets listed on http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
  # WARN: do not bind to ^L or ^V
  bindkey -v # press <ESC> to enter NORMAL mode, press i to enter INSERT mode
  bindkey "^A" beginning-of-line
  bindkey "^B" backward-word
  bindkey "^W" forward-word
  bindkey "^E" end-of-line
  bindkey "^C" kill-line
  bindkey "^X" backward-kill-word
  bindkey "^Y" vi-yank-whole-line # yank entire line to killer
  bindkey "^Z" insert-last-word # insert word from last Entered command
  bindkey "^H" beginning-of-history
  bindkey "^O" down-line-or-search
  bindkey "^P" up-line-or-search
  bindkey '^R' history-incremental-search-backward
  stty -ixon # gives access to ^Q
  bindkey -s "^Q" "^[Isudo ^[A" # Tab key, prepend sudo

  # Disable (-r) Up/Down arrow keys to practice ^O/^P
  # bindkey -r "^[[A" # Up arrow key
  # bindkey -r "^[[B" # Down arrow key
  # bindkey -r "^[[C" # Right arrow key
  # bindkey -r "^[[D" # Left arrow key
  # ^I is Tab key

  # Display Vi-mode in prompt
  function zle-line-init zle-keymap-select {
      # VIM_PROMPT="%{$fg_bold[red]%}Vi%{$reset_color%}"
      # RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$EPS1"

      # read more on: http://unix.stackexchange.com/questions/547/make-my-zsh-prompt-show-mode-in-vi-mode
      # also read up: http://martin.krischik.com/index.php/Z-Shell/VimMode
      # RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
      RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/}$EPS1"
      zle reset-prompt
  }
  zle -N zle-line-init
  zle -N zle-keymap-select
  export KEYTIMEOUT=1 # 0.4 to 0.1 sec delay in Vim mode display change, raise value if other commands getting issues

  [[ -f "${HOME}/.ztmux" ]] && source "${HOME}/.ztmux"
elif [[ ($TERM_PROGRAM == "Apple_Terminal") ]]; then # iTerm2
  # iTerm2 shell integration with Unix shell
  if [[ ! -h "${HOME}/.iterm2_shell_integration.zsh" ]]; then # check if file is Symlink
    # Custom shell loading for iTerm
    ln -s ${HOME}/.dotfiles/config/term/iterm2_shell_integration.zsh ${HOME}/.iterm2_shell_integration.zsh;
  fi

  # Rename title displayed from tabs in iTerm
  title () {
    if [[ $# == 0 ]] then
      echo -ne "\e]1;$PWD\a"
    else
      echo -ne "\e]1;$@\a"
    fi
  }

  # use iterm2_shell_integration.`basename $SHELL` when dealing with multiple shells
  test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
else # Other
  if [[ -h "${HOME}/.iterm2_shell_integration.zsh" ]]; then
    rm "${HOME}/.iterm2_shell_integration.zsh" && echo "removed ~/.iterm2_shell_integration.zsh";
  fi
fi

# Rename tabs automatically
# rename tab - version 1
case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;${PWD/#${HOME}/~}\a"}
        ;;
esac

# rename tab - version 2
# case $TERM in
#   xterm*|*rxvt*)
#     temu="urxvt"
#     preexec () {
#       if [[ $(echo -e $1 | tr -d '\040\011\012\015') = "reset" ]]; then
#         1="$temu"
#       else
#         1="$1 - $temu"
#       fi
#       print -Pn "\e]0;$1\a"
#     }
#   ;;
# esac

# Clears the "Last login" message at startup
# clear;

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
