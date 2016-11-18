#
# User configuration sourced by interactive shells
#

# Source zim's init.zh, which sources ~/.zimrc, which decides prompt theme
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

# Symlink custom prompt if not there
if [[ ! -h ~/.zim/modules/prompt/functions/prompt_mingit_setup ]]; then
  ln -s "$HOME/.zprompt" "$HOME/.zim/modules/prompt/functions/prompt_mingit_setup"
fi

skip_global_compinit=1 # faster Zsh startup
autoload -Uz promptinit
promptinit
prompt mingit

DEFAULT_USER="irliao" # replaces user@hostname with specified username
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

export EDITOR='vim'
export PAGER="less"
export LESS="-R" # -R for ANSI color codes only
export DEVPATH="$HOME/Developments"
export HISTCONTROL=erasedups  # Ignore duplicate entries in history
export HISTIGNORE="&:ls:ll:la:l.:pwd:exit:clear:clr:[bf]g"

# Colors in Manual page
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Brew
fpath=("/usr/local/bin/" $fpath)
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/opt/homebrew-cask/Caskroom" # install path
export HOMEBREW_NO_ANALYTICS=1 # opt-out of analytics
# export TRAVIS=1 # bypass missing xCode 8 error on osx10.12

# Go
# export GOPATH="$DEVPATH/go"
# export PATH="$PATH:$GOPATH/bin"

# Node
# export NVM_DIR="$HOME/.nvm"
# . "$(brew --prefix nvm)/nvm.sh"
# export PATH=~/.npm-global/bin:$PATH

# The Fuck
eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"

setopt MENU_COMPLETE # completion with > 1 choices will auto insert first choice
unsetopt flowcontrol # disables ^S (freeze) and ^Q (resume) terminal output

# List files upon change directory
function chpwd() {
  emulate -L zsh
  ls
}

# Redraw prompt when Terminal size changes, fixes Tmux window size
TRAPWINCH() {
  zle &&  zle -R
}

# Custom functions
[[ -f "${HOME}/.zfunction" ]] && source "${HOME}/.zfunction"

# Custom aliases, should source after custom functions incase aliasing functions
[[ -f "${HOME}/.zalias" ]] && source "${HOME}/.zalias"

# Bash profile
[[ -f "${HOME}/.bash_profile" ]] && source "${HOME}/.bash_profile"

# Use 256 color terminal
export TERM="xterm-256color"

# Key bindings
bindkey "^A" beginning-of-line
bindkey "^B" backward-word
bindkey "^C" kill-line
bindkey "^E" end-of-line
bindkey "^O" down-line-or-search
bindkey "^P" up-line-or-search
bindkey "^W" forward-word
# bindkey -s '\es' '^Asudo ^E' # \e is Alt-key, Alt+S to prepend sudo to command then go to eol
# bindkey '\e.' insert-last-word # TODO: figure out how to press: \e.


# Terminal customizations
if [[ ($TERM_PROGRAM == "Apple_Terminal") ]]; then # Apple Terminal
  if [[ -h "${HOME}/.iterm2_shell_integration.zsh" ]]; then rm "${HOME}/.iterm2_shell_integration.zsh" && echo "removed ~/.iterm2_shell_integration.zsh"; fi

  # Key bindings
  stty -ixon # gives access to ^Q
  bindkey "^X" backward-kill-word
  bindkey "^Y" vi-yank-whole-line # yank entire line to killer
  bindkey "^H" beginning-of-history
  bindkey "^R" history-incremental-search-backward

  # Vim mode
  bindkey -v # press <ESC> to enter NORMAL mode, press i to enter INSERT mode, NOTE: disables Shift-Tab in iTerm2
  function zle-line-init zle-keymap-select {
    # Display Vim mode in prompt
    VIM_PROMPT="%{$fg_bold[yellow]%}NORMAL%{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$EPS1"
    zle reset-prompt
  }
  zle -N zle-line-init
  zle -N zle-keymap-select
  export KEYTIMEOUT=1 # 0.4 to 0.1 sec delay in Vim mode display change, raise value if other commands getting issues

  [[ -f "${HOME}/.zmux" ]] && source "${HOME}/.zmux"
# iTerm2 customizations
elif [[ ($TERM_PROGRAM == "iTerm.app") ]]; then
  # iTerm2 shell integration with Unix shell
  [[ ! -h "${HOME}/.iterm2_shell_integration.zsh" ]] && ln -s ${HOME}/.dotfiles/config/term/iterm2/iterm2_shell_integration.zsh ${HOME}/.iterm2_shell_integration.zsh;

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
  clear;
else # Other
  [[ -h "${HOME}/.iterm2_shell_integration.zsh" ]] && rm "${HOME}/.iterm2_shell_integration.zsh" && echo "removed ~/.iterm2_shell_integration.zsh";
fi

# Rename tabs automatically
# rename tab - version 1
# case $TERM in
#     xterm*)
#         precmd () {print -Pn "\e]0;${PWD/#${HOME}/~}\a"}
#         ;;
# esac

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

# Unused settings

# PATH configured to work with NPM global installs (without sudo)
# NPM_PACKAGES="${HOME}/.node_modules_global"
# NPM_PACKAGES_BIN="${HOME}/.node_modules_global/bin" # include in PATH if setting prefix with .npmrc
# unset MANPATH
# export MANPATH="$NPM_PACKAGES/share/man:$(manpath)" # include manuals from npm modules
