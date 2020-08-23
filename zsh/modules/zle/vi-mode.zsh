function print_dcs
{
  print -n -- "\EP$1;\E$2\E\\"
}

function set_cursor_shape
{
  if [ -n "$TMUX" ]; then
    # tmux will only forward escape sequences to the terminal if surrounded by
    # a DCS sequence
    print_dcs tmux "\E]50;CursorShape=$1\C-G"
  else
    print -n -- "\E]50;CursorShape=$1\C-G"
  fi
}

function zle-keymap-select zle-line-init
{
  case $KEYMAP in
    vicmd)
      set_cursor_shape 0 # block cursor
      ;;
    viins|main)
      set_cursor_shape 1 # line cursor
      ;;
  esac
  zle reset-prompt
  zle -R
}

function zle-line-finish
{
  set_cursor_shape 0 # block cursor
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# vim:set ft=zsh:
# # get aborted lines (Control-C) back with undo
# zle-line-init() {
#   if [[ -n $ZLE_LINE_ABORTED ]]; then
#     local savebuf="$BUFFER" savecur="$CURSOR"
#     BUFFER="$ZLE_LINE_ABORTED" 
#     CURSOR="$#BUFFER" 
#     zle split-undo
#     BUFFER="$savebuf" CURSOR="$savecur" 
#   fi
#   # zle -K viins
# }

# # use cursor as indicator of vi mode
# zle-keymap-select () {
#     if [ $KEYMAP = vicmd ]; then
#         if [[ $TMUX = '' ]]; then
#             echo -ne "\033]12;Red\007"
#         else
#             printf '\033Ptmux;\033\033]12;red\007\033\\'
#         fi
#     else
#         if [[ $TMUX = '' ]]; then
#             echo -ne "\033]12;Grey\007"
#         else
#             printf '\033Ptmux;\033\033]12;grey\007\033\\'
#         fi
#     fi
# }

