# Run when starting a new bash instance by typing /bin/bash
# Sourced every time a new shell is opened

# Should contain PATH and common settings so when .bash_profile
# sources this file at each new window, PATH is applied to both config files

# If Shell sourcing this script is not running interactively, then don't do anything yet.
# Returning early makes the script sourced only once (during shell on startup).
# Make sure to have no outputs when dealing with interactive shell since those shell (scp and rcp) don't tolerate any output
# TODO: figure out how this is different from the interactive shell check below
# [ -z "$PS1" ] && return


# Test for an interactive shell.  There is no need to set anything past this point for scp and rcp,
# and it's important to refrain from outputting anything in those cases.
if [[ $- != *i* ]] ; then
  # Shell is non-interactive.  Be done now!
  return
fi

# shopt -s checkwinsize # If window size changes, redraw contents
# shopt -s histappend # append to the history file, don't overwrite it
# shopt -s dotglob # include filenames beginning with a ‘.’ in the results of filename expansion

HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history, see bash(1) for more options
HISTSIZE=2000 # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE=5000


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
# export DISABLE_AUTO_TITLE=true # TODO: figure out what this does

# colors
Color_Off='\e[0m'            # Text Reset
Color_Off_='\[\e[0m\]'       # Text Reset
BPurple='\e[1;35m'           # Purple
BWhite='\e[1;37m'            # White

# localhost
PS1='\[\033[0;32m\]\w >:\[\033[0m\]'
# remote hosts
#PS1='\[\033[0;32m\]\u@\h:\w >:\[\033[0m\]'

# TODO: uncomment once it's customized to resemble current Zsh prompt
# prompt setup
# PROMPT_DIRTRIM=2
# set_prompt () {
#     local last_command=$?
#     PS1=''

#     # save after every command
#     history -a

#     # color escape codes
#     local color_off='\[\e[0m\]'
#     local color_red='\[\e[0;31m\]'
#     local color_green='\[\e[0;32m\]'
#     local color_yellow='\[\e[0;33m\]'
#     local color_blue='\[\e[0;34m\]'
#     local color_purple='\[\e[0;35m\]'
#     local color_cyan='\[\e[0;36m\]'

#     # add purple exit code if non-zero
#     if [[ $last_command != 0 ]]; then
#       PS1+=$color_purple
#       PS1+='$? '
#       PS1+=$color_off
#     fi

#     # shortened working directory
#     PS1+='\w '

#     # TODO: source/integrate __git_ps1 defined in ~/.dotfiles/config/shell/git-prompt.sh
#     # add Git status with color hints
#     PS1+="$(__git_ps1 "%s ")"

#     # red for root, off for user
#     if [[ $EUID == 0 ]]; then
# 	PS1+=$color_red
#     else
# 	PS1+=$color_off
#     fi

#     # end of prompt
#     PS1+='|-'
#     PS1+=$color_red
#     PS1+='/ '
#     PS1+=$color_off
# }
# PROMPT_COMMAND='set_prompt'

# Alias definitions.
if [ -f ~/.bash_alias ]; then
    . ~/.bash_alias
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

PATH=$HOME/bin:/usr/local/bin:$PATH
# TODO: uncomment after updating the PATH
# PATH=$PATH:$HOME/src/bin
# if [ -z /opt/local/bin ]; then
#     PATH=$PATH:$HOME/opt/local/bin
# fi

EDITOR='/usr/bin/vim'
export LANG="en_US.utf8"
export LC_ALL=C

# Colors for 'ls -G' in Apple Terminal, LSCOLORS details at: http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
#
# Node Version Manager (NVM)
# export NVM_DIR="${HOME}/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

alias ls="ls -G" # the -G option only exists for Bash version of ls
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Vi mode (start in Insert mode)
set -o vi
