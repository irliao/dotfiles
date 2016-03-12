#
# mingit theme
# https://github.com/shashankmehta/dotfiles/blob/master/thesetup/zsh/.oh-my-zsh/custom/themes/mingit.zsh-theme
# ❯ ➜
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

# rbenv_version_status() {
#   local ver=$(rbenv version-name)
#   [ "$(rbenv global)" != "$ver" ] && echo "[$ver]"
# }

# virtualenv_info() {
#   [ $VIRTUAL_ENV ] && echo '('%F{blue}`basename $VIRTUAL_ENV`%f') '
# }

# current_branch() {
#   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#   echo ${ref#refs/heads/}
# }

# git_custom_prompt_info() {
#   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#   echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
# }

# # TODO: get this to return untrack correctly without lag
# git_get_status() {
#   gitstat=$(git status 2>/dev/null | grep '\(# Untracked\|# Changes\|# Changed but not updated:\)')

#   if [[ $(echo ${gitstat} | grep -c "^\(# Untracked files:\|# Changed but not updated:\)$") > 0 ]]; then
# 	  print "$ZSH_THEME_GIT_PROMPT_UNTRACKED"
#   else
#     print "$(parse_git_dirty)"
#   fi
# }

# TODO: possibly migrate this to display in Tmux instead
# Print Node version if different than default from ~/.nvmrc
node_ver_status() {
  local ver=$(node --version)
  [ "$(cat ~/.nvmrc)" != "$ver" ] && echo "%F{yellow}($ver)%f"
}

gst_get_prefix() {
  # print "%(?:%F{6}➜ :%F{6}➜ )%f"
  print "%(?:%F{6} :%F{6} )%f"
}

gst_get_suffix() {
  # print "%(?:%F{2}❯ :%F{1}❯ %s)%f"
  print "%(?:%F{2}$ :%F{1}$ )%f"
}

gst_get_pwd() {
  prompt_short_dir="$(short_pwd)"
  git_root="$(command git rev-parse --show-toplevel 2> /dev/null)"
  prompt_short_dir="${prompt_short_dir#${$(short_pwd $git_root):h}/}"
  print "%F{8}${prompt_short_dir}%f"
}

gst_get_rprompt() {
  print "%F{15}%*%f"
}

prompt_mingit_precmd() {
  # PROMPT="$(gst_get_prefix)$(gst_get_pwd)$(parse_git_dirty)$(git_prompt_info)$(gst_get_suffix)"
  PROMPT="$(gst_get_prefix)$(gst_get_pwd)$(parse_git_dirty)$(git_prompt_info)$(gst_get_suffix)"
  RPROMPT=''
}

prompt_mingit_setup() {
	export PROMPT_EOL_MARK='' # prevent percentage showing up if output doesn't end with a newline
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
  prompt_opts=(cr percent subst)

  ZSH_THEME_GIT_PROMPT_PREFIX=""
  ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
  ZSH_THEME_GIT_PROMPT_DIRTY=" %F{1}"
  ZSH_THEME_GIT_PROMPT_CLEAN=" %F{6}"
  # ZSH_THEME_GIT_PROMPT_UNTRACKED=" %F{3}"

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd prompt_mingit_precmd
  # TODO: implement hook for cwdcmd
}

prompt_mingit_setup "$@"
