#!/bin/sh

brew cask install macdown && 

# TODO: only do this if brew cask did not create symlink
ln -s /Applications/MacDown.app/Contents/SharedSupport/bin/macdown /usr/local/bin

# EOF