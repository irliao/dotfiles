#!/bin/sh

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export PATH=/bin:/usr/bin:/usr/local/bin | export PATH=$HOME/bin:/usr/local/bin:$PATH # Default $PATH

export DISABLE_AUTO_TITLE=true

# Node Version Manager (NVM)
export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# EOF
