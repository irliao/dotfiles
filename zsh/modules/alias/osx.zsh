# OSX utilities

alias osxReboot="sudo reboot"
alias osxPoweroff="sudo poweroff"

alias osxVer="sw_vers"
alias osxUnmountDisk="hdiutil detach"
alias osxMountDisk="hdiutil attach"
alias osxEjectAllVolumes="osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'"
alias osxClipboardNoFormat="pbpaste | textutil -convert txt -stdin -stdout -encoding 30 | pbcopy"
alias osxOpeniCloud="cd $HOME/Library/Mobile Documents/com~apple~CloudDocs/"
alias osxResetSpotlight="sudo mdutil -E /" # / can be replaced by any path to volume
alias osxShowSpotlightIndex="sudo mdls /" # / can be replaced by any path to show as root
alias osxMakeNewPassword="tr -dc A-Za-z0-9_ < /dev/urandom | head -c 20 | pbcopy"
alias airportcycle='networksetup -setairportpower airport off; networksetup -setairportpower airport on'
alias osxTestBandwidth="wget http://cachefly.cachefly.net/100mb.test -O /dev/null"
alias osxUptime="uptime | cut -d ',' -f 2- | cut -c 1-6"
alias osxEjectAllDisks="osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'"
alias osxListAllDisks="diskutil list"
alias osxScreenSaver="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"
alias osxUpdateApps="sudo softwareupdate -ia"
alias osxAppStoreApps="find /Applications -path '*Contents/_MASReceipt/receipt' -maxdepth 4 -print |\sed 's#.app/Contents/_MASReceipt/receipt#.app#g; s#/Applications/##'"
alias osxCleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
alias osxCompName="scutil --get ComputerName"
alias osxLocalHostName="scutil --get LocalHostName"
alias osxBootTime='sysctl -a |grep kern.boottime'
alias osxIpv4v6="ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'"
alias osxWakeReason='syslog |grep -i "Wake reason"'
alias osxNetworkPorts='networksetup -listallhardwareports'
alias osxCancelAllPrinterJobs="cancel -a -"
alias osxXCodeVersion="/usr/bin/xcodebuild -version"
alias osxChromeNoCSR="open -a Google\ Chrome --args --disable-web-security -–allow-file-access-from-files"
alias osxAllPortStatus="netstat -anp tcp && lsof -i tcp"
# alias osxBltKbBattery="ioreg -c AppleBluetoothHIDKeyboard |grep Battery"
alias osxBltKbBatteryPercent="ioreg -c AppleBluetoothHIDKeyboard |grep BatteryPercent"
# alias osxBltMouseBattery="ioreg -n BNBMouseDevice | grep -i Battery"
alias osxBltMouseBatteryPercent="ioreg -n BNBMouseDevice | grep -i BatteryPercent"
