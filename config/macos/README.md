# macOS

TODO: write install script, use $? variable to check if csrutil status | grep enabled returns true or false
sudo mv /System/Library/CoreServices/Menu\ Extras/Battery.menu ~/Downloads/Battery.menu
sudo cp -R ~/.dotfiles/config/macos/Battery.menu /System/Library/CoreServices/Menu\ Extras/Battery.menu
killall SystemUIServer
reboot
