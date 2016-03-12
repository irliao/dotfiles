#
# Executes commands at login post-zshrc.
#
# This should contain commands that should be executed only in login shells.
# A per-user configuration file, will be sourced at the ending of initial progress when starting as a login shell.
# Not the place for alias definitions, options, environment variable settings, etc.; as a general rule, it should not change the shell environment at all.
# Should be used to set the terminal type and run a series of external commands (fortune, msgs, etc).

# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!