shopt -s dotglob           # includes dotfiles in pathname expansion
shopt -s checkwinsize      # If window size changes, redraw contents

# Run when starting a new bash instance by typing /bin/bash
# Sourced every time a new shell is opened

# Should contain PATH and common settings so when .bash_profile
# sources this file at each new window, PATH is applied to both config files

# export PATH=$HOME/bin:/usr/local/bin:$PATH

# export DISABLE_AUTO_TITLE=true

# TODO: fix error: complete not found
# Bash autocompletion
# complete -W "$(teamocil --list)" teamocil

# Node Version Manager (NVM)
# export NVM_DIR="${HOME}/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

