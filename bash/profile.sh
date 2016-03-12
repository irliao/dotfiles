#!/bin/sh

# The systemwide initialization file, executed for login shells
# Default loaded from /etc/profile
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

# EOF
