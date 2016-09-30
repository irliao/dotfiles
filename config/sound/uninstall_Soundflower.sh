#!/bin/sh

rm -rf /Library/Extensions/Soundflower.kext

rm -rf /System/Library/Extensions/Soundflower.kext

# NOTE: Code below is the AppleScript from the official Soundflower uninstaller
# on run
# 	do shell script "sudo rm -rf /System/Library/Extensions/Soundflower.kext" with administrator privileges
# 	do shell script "sudo rm -rf /Library/Receipts/Soundflower*" with administrator privileges
# 	do shell script "sudo rm -rf /var/db/receipts/com.cycling74.soundflower.*" with administrator privileges
# 	do shell script "sudo rm -rf /Applications/Soundflower" with administrator privileges
# 	"Done!"
# end run

echo "finished running uninstall_Soundflower.sh"

