#
# mingit theme
#

gst_get_prefix() {
  print "%(?:%F{6} :%F{6} %s)%f"
}

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
