#!/bin/sh

# TODO - script to symlink all necessary dot files

rm ~/.amethyst
rm ~/.hammerspoon

ln -s ~/.dotfiles/amethyst/amethyst.json ~/.amethyst
ln -s ~/.dotfiles/hammerspoon ~/.hammerspoon

# EOF