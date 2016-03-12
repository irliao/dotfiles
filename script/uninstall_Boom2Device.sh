#!/bin/sh
su admin -c "sudo kextunload -b com.globaldelight.driver.Boom2Device; \
                sudo rm -rf /System/Library/Extensions/BoomDevice.kext; \
                sudo rm -rf /Library/Extensions/Boom2Device.kext;"

# AppleScript
# on run
# do shell script "sudo kextunload -b com.globaldelight.driver.Boom2Device" with administrator privileges
# do shell script "sudo rm -rf /System/Library/Extensions/BoomDevice.kext" with administrator privileges
# do shell script "sudo rm -rf /Library/Extensions/Boom2Device.kext" with administrator privileges
# end run
    
# EOF
