#
# Executes commands at logout.
#
# A per-user configuration file, will be sourced when a login shell exits.

# Cleans Env from Work
# if [[ "$(whoami)" == "iliao" && -s "${ZDOTDIR:-$HOME}/.ttoenv" ]]; then
#     mv ~/.ttoenv ~/.ttoenv-bak &&
#     sed "5s/.*/export TTO_PASSWD=''/" ~/.ttoenv > ~/.ttoenv &&
#     rm ~/.ttoenv-bak &&
#     echo "WARNING: Cleaned ~/.ttoenv"
# fi

# Print the message.
cat <<-EOF
Logging out.
 -- $(whoami)
EOF

# EOF