#!/bin/sh

cd ~/Library/Preferences/
mv ./com.apple.finder.plist ~/Archives/finder_plist_backup
echo "Please Restart the Mac!"
sudo shutdown -r now "Restarting Now"

# EOF