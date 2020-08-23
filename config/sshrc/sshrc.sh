# Symlinked to ~/.sshrc on local machine to be sourced with all sshrc calls

# TODO: use pattern below for server specific configs
# if [ $(hostname | grep server1 | wc -l) == 1 ]; then
#     echo 'server1'
# fi
# if [ $(hostname | grep server2 | wc -l) == 1 ]; then
#     echo 'server2'
# fi

# aliases
alias ..='cd ..'

# vim settings
export VIMINIT="let \$MYVIMRC='$SSHHOME/.sshrc.d/.vimrc' | source \$MYVIMRC"

if type zsh >/dev/null 2>&1; then
  exec zsh
fi

echo 'Loaded sshrc'
