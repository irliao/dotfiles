#!/bin/sh

# Symlink CLI

# Left here to show how to write script to redirect command to another user
# su admin -c "brew update && brew upgrade && brew prune && brew cleanup && \
#                 brew uninstall --force brew-cask; brew update"

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Done: setup_brew_sudo.sh"
