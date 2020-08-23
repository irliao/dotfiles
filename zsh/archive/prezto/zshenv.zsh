#
# Defines environment variables.
#
# This is sourced on all invocations of the shell, unless the -f option is set.
# This file should contain commands to set the global command search path and other system-wide environment variables.
# This should not contain commands that produce output or assume the shell is attached to a tty.
# Similar to /etc/zsh/zshenv but for per-user configuration. Generally used for setting some useful environment variables.

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi