# vim: ft=zsh
#
# Mingit Theme
# @author: irliao
#

# NOTE: synlink ~/.zim/modules/prompt/functions/prompt_mingit_setup -> /Users/irliao/.dotfiles/zsh/prompts/mingit.zsh

# indent prompt by 1 space
gst_get_prefix() {
  print " "
}

# green - last command success, red - last command failed
gst_get_suffix() {
  print "%(?:%F{2}$ :%F{1}$ %s)%f"
}

gst_get_pwd() {
  prompt_short_dir="$(short_pwd)"
  git_root="$(command git rev-parse --show-toplevel 2> /dev/null)" && \
  prompt_short_dir="${prompt_short_dir#${$(short_pwd $git_root):h}/}"
  print ${prompt_short_dir}
}

prompt_mingit_precmd() {
  PROMPT="$(gst_get_prefix)%F{8}$(gst_get_pwd)%f$(parse_git_dirty)$(git_prompt_info)$(gst_get_suffix)"

  # TODO: determine if this is useful to keep or not
  PROMPT="$PROMPT"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
}

prompt_mingit_setup() {
  ZSH_THEME_GIT_PROMPT_PREFIX=""
  ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
  ZSH_THEME_GIT_PROMPT_DIRTY=" %F{1}"
  ZSH_THEME_GIT_PROMPT_CLEAN=" %F{6}"

  autoload -Uz add-zsh-hook

  add-zsh-hook precmd prompt_mingit_precmd
  prompt_opts=(cr subst percent)
}

prompt_mingit_setup "$@"

# TODO: figure out how this implementation is different
# gst_get_pwd(){
#   git_root=$PWD
#   while [[ $git_root != / && ! -e $git_root/.git ]]; do
#     git_root=$git_root:h
#   done
#   if [[ $git_root = / ]]; then
#     unset git_root
#     prompt_short_dir=%~
#   else
#     parent=${git_root%\/*}
#     prompt_short_dir=${PWD#$parent/}
#   fi
#   echo $prompt_short_dir
# }

