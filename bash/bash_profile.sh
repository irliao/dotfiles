#!/bin/sh

# The personal initialization file, executed for login shells
# Executed to configure the shell before the initial command prompt
# Put stuff you only want to see on login

# WARN: Mac OS X Terminal runs login shell by default for each
# new terminal window; calling .bash_profile instead of .bashrc.

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
