# Debug Utils

# NOTE: should only be sourced when debugging Zsh configurations and frameworks

# Shell Utils
alias opts='setopt' # show all options set in current shell
alias envs='env' # show all environment variables set in current shell
alias re='reset'
alias al='alias'
alias ua='unalias'
alias ta='type -a' # show where arg1 (command, alias, function, etc) is sourced from

# Hotkey Utils
alias bindkey-ls="bindkey -L" # list existing bindkeys
alias termkey-ls="infocmp -L $TERM" # list existing keycodes for current TERM

# TODO: echo out all the available utils sourced
