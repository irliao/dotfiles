#!/bin/sh

# Override git to use RSA private key
# Putting this in a .rc file will slow down git, so storing git() in a shell script in $PATH
# This script should be moved to ~/.bin as executable cli once its finished

git(){
    trap 'rm -f /tmp/.git_ssh.$$' 0
    SSH_KEY="~/.ssh/id_rsa"
    echo "ssh -i $SSH_KEY \$@" > /tmp/.git_ssh.$$
    chmod +x /tmp/.git_ssh.$$
    export GIT_SSH=/tmp/.git_ssh.$$
    [ "$1" = "git" ] && shift
    git "$@"
}
