#!/bin/sh

brew cask install macdown && 

# TODO: only do this if brew cask did not create symlink
ln -s /Applications/MacDown.app/Contents/SharedSupport/bin/macdown /usr/local/bin

# TODO: verify this actually works
macdown_themes_dir=${HOME}/.dotfiles/config/macdown
if [ -d $macdown_themes_dir ]; then
    for macdown_theme in $macdown_themes_dir
    do
        if [ ${macdown_theme : -6} == ".style" ]; then
            ln -s $macdown_theme $HOME/Library/Application\ Support/MacDown/Themes/ && echo "Successfully symlinked MacDown themes";
        fi
    done
fi

# EOF
