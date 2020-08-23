# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
# original source: https://gist.github.com/AbigailBuccaneer/1fcf12edf13e03e45030

# TODO: figure out when is the correct time to source this file (currently somewhere after bindkey -v)
# TODO: consider converting this to a module, refer to: https://github.com/alexbepple/zsh-config/blob/master/modules/keys
# TODO: determine if need to have '# !/usr/bin/env zsh' at the top

zmodload zsh/terminfo
typeset -gA key

# TODO: refactor this to a generic function
# print -lr ${(q)terminfo[kend]} # prints escaped sequences as string, like kend (End) prints $'\033'OF

# TODO: refactor $key to be this format
# key_info=(
#   'Control'      '\C-'
#   'ControlLeft'  '\e[1;5D \e[5D \e\e[D \eOd'
#   'ControlRight' '\e[1;5C \e[5C \e\e[C \eOc'
#   'Escape'       '\e'
#   'Meta'         '\M-'
#   'Backspace'    "^?"
#   'Delete'       "^[[3~"
#   'F1'           "$terminfo[kf1]"
#   'F2'           "$terminfo[kf2]"
#   'F3'           "$terminfo[kf3]"
#   'F4'           "$terminfo[kf4]"
#   'F5'           "$terminfo[kf5]"
#   'F6'           "$terminfo[kf6]"
#   'F7'           "$terminfo[kf7]"
#   'F8'           "$terminfo[kf8]"
#   'F9'           "$terminfo[kf9]"
#   'F10'          "$terminfo[kf10]"
#   'F11'          "$terminfo[kf11]"
#   'F12'          "$terminfo[kf12]"
#   'Insert'       "$terminfo[kich1]"
#   'Home'         "$terminfo[khome]"
#   'PageUp'       "$terminfo[kpp]"
#   'End'          "$terminfo[kend]"
#   'PageDown'     "$terminfo[knp]"
#   'Up'           "$terminfo[kcuu1]"
#   'Left'         "$terminfo[kcub1]"
#   'Down'         "$terminfo[kcud1]"
#   'Right'        "$terminfo[kcuf1]"
#   'BackTab'      "$terminfo[kcbt]"
# )

key[Control]='\C-'
key[Backspace]="^?"
key[Delete]="^[[3~"
key[Tab]='^I'
key[BackTab]=${terminfo[kcbt]}
key[Space]=' '

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# Reset to default key bindings.
bindkey -d

# setup key accordingly
[[ -n "${key[BackTab]}"    ]]  && bindkey  "${key[BackTab]}" reverse-menu-complete
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char

# [[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      history-beginning-search-backward
# [[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    history-beginning-search-forward
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# TODO: merge with zle functions defined in ~/.zshrc, should call echoti commands first in all overwritten zle functions, refer to https://github.com/sorin-ionescu/prezto/blob/master/modules/editor/init.zsh
# Make sure that the terminal is in application mode when zle is active, since only then values from $terminfo are valid
# Application Mode explanation: http://git.suckless.org/st/tree/FAQ
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  # Finally, make sure the terminal is in application mode, when zle is
  # active. Only then are the values from $terminfo valid.
  function zle-line-init () {
      echoti smkx
  }
  function zle-line-finish () {
      echoti rmkx
  }

  zle -N zle-line-init
  zle -N zle-line-finish  
fi

## Fix weird sequence that rxvt produces
#bindkey -s '^[[Z' '\t'

# TODO: check if following is useful
# Home/End keys in Zsh (https://blog.rabin.io/tag/zsh)
# bindkey '\e[1~'   beginning-of-line  # Linux console
# bindkey '\e[H'    beginning-of-line  # xterm
# bindkey '\eOH'    beginning-of-line  # gnome-terminal
# bindkey '\e[2~'   overwrite-mode     # Linux console, xterm, gnome-terminal
# bindkey '\e[3~'   delete-char        # Linux console, xterm, gnome-terminal
# bindkey '\e[4~'   end-of-line        # Linux console
# bindkey '\e[F'    end-of-line        # xterm
# bindkey '\eOF'    end-of-line        # gnome-terminal

