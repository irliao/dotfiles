#!/usr/bin/env bash

# Defaults specific for macOS Mojave

# Change login screen background, requires logout to apply change
[[ -f /Library/Desktop\ Pictures/Mojave.heic ]] &&
  [[ ! -h /Library/Desktop\ Pictures/Mojave.heic ]] && # make sure file is not a symlink
  sudo mv /Library/Desktop\ Pictures/Mojave.heic /Library/Desktop\ Pictures/Mojave-default.heic && # backup original background image
  sudo ln -s ~/.dotfiles/config/macos/github_wallpaper.jpg /Library/Desktop\ Pictures/Mojave.heic

# Font Smoothing
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO # NO = enable font smoothing
defaults -currentHost write -globalDomain AppleFontSmoothing -int 2 # 3/2/1 = Strong/Medium/Light font smoothing, 2 is best for flat panel
# defaults -currentHost delete -globalDomain AppleFontSmoothing # remove custom font smoothing settings
killall Finder
