#!/bin/sh

# TODO: should check if Amethyst is installed and ~/.amethyst exists

# Remove .plist from App
rm $HOME/Library/Preferences/com.amethyst.Amethyst.plist

# Remove old default config
rm /Applications/Amethyst.app/Contents/Resources/default.amethyst

# Symlink default config
ln -s $HOME/.amethyst /Applications/Amethyst.app/Contents/Resources/default.amethyst
