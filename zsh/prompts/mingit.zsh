#
# mingit theme
#

# # Unused functions
# # require ~/.bin/battery_info.py included in PATH
# function battery_charge() {
#   # echo `$BAT_CHARGE` 2>/dev/null
#   if [[ -e ~/bin/batcharge.py ]] then
#     echo `python ~/bin/batcharge.py`;
#   else
#     echo '';
#   fi
# }

# git_custom_prompt_info() {
#   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#   echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
# }

gst_get_prefix() {
  print "%(?:%F{6} :%F{6} )%f"
}

gst_get_suffix() {
  print "%(?:%F{2}$ :%F{1}$ )%f"
}

gst_get_pwd() {
  prompt_short_dir="$(short_pwd)"
  git_root="$(command git rev-parse --show-toplevel 2> /dev/null)"
  prompt_short_dir="${prompt_short_dir#${$(short_pwd $git_root):h}/}"
  print "%F{8}${prompt_short_dir}%f"
}

# gst_get_rprompt() {
#   print "%F{15}%*%f"
# }

prompt_mingit_precmd() {
  PROMPT="$(gst_get_prefix)$(gst_get_pwd)$(parse_git_dirty)$(git_prompt_info)$(gst_get_suffix)"
}

# function zle-line-init zle-line-finish zle-keymap-select {
#   zle reset-prompt
#   zle -R
# }

prompt_mingit_setup() {
  ZSH_THEME_GIT_PROMPT_PREFIX=""
  ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
  ZSH_THEME_GIT_PROMPT_DIRTY=" %F{1}"
  ZSH_THEME_GIT_PROMPT_CLEAN=" %F{6}"

  emulate -L zsh
  # setopt LOCAL_OPTIONS EXTENDED_GLOB # extended globbing is needed for listing autoloadable function directories
  # unsetopt XTRACE KSH_ARRAYS

  autoload -Uz add-zsh-hook

  # # TODO: verify this fixes window size with Tmux
  # # Unsets the Terminal.app current working directory when a terminal
  # # multiplexer or remote connection is started since it can no longer be
  # # updated, and it becomes confusing when the directory displayed in the title
  # # bar is no longer synchronized with real current working directory.
  # function _terminal-unset-terminal-app-proxy-icon {
  #   if [[ "${2[(w)1]:t}" == (screen|tmux|dvtm|ssh|mosh) ]]; then
  #     print '\e]7;\a'
  #   fi
  # }
  # add-zsh-hook preexec _terminal-unset-terminal-app-proxy-icon

  add-zsh-hook precmd prompt_mingit_precmd
  prompt_opts=(cr percent subst)
}

prompt_mingit_setup "$@"
