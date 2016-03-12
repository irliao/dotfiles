#!/bin/sh

# make Apple's default Crash Report Screen into Notification
defaults write com.apple.CrashReporter UseUNC 1

# enable debug mode in Safari
defaults write com.apple.Safari IncludeInternalDebugMenu 1

# disable Desktop icons
defaults write com.apple.finder CreateDesktop -bool false

# save screenshots to Downloads/
defaults write com.apple.screencapture location ~/Downloads 

# crash window reports in Notification Center
defaults write com.apple.CrashReporter UseUNC 1

# disable Window resizing Animation speed
defaults write -g NSWindowResizeTime -float 0.001

# enable key repeat instead of accent key when held down
defaults write -g ApplePressAndHoldEnabled -bool false

# key repeat rate when held down, 0 is fastest
defaults write NSGlobalDomain KeyRepeat -int 2

# time needed for key repeat to occur, DO NOT go lower than 5
# defaults write NSGlobalDomain InitialKeyRepeat -int 10

# disable opening/closing Window animation
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# disable animation in Quicklook
defaults write -g QLPanelAnimationDuration -float 0

# disable Window animation and Get Info animation in Finder
defaults write com.apple.finder DisableAllAnimations -bool true

# do not animate opening apps from Dock
defaults write com.apple.dock launchanim -bool false

defaults write com.apple.dock expose-animation-duration -float 0.1

# disable send/reply animation in Mail
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# disable copying full name with email in Mail
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# disable image attachment previews
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# reduce render delay in Safari
defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25

# show absolute path in Finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES

# faster key repeat when held down, set to 0 to try almost instant delete
defaults write NSGlobalDomain KeyRepeat -int 2

# disable Dock hiding animation
defaults write com.apple.Dock autohide-delay -float 0

# disable rendering delay of webpages in Safari
defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25

# make holding key repeat key normally instead of showing accented key
defaults write -g ApplePressAndHoldEnabled -bool false

# reduce transparency in all
defaults write com.apple.universalaccess reduceTransparency -bool true

# show hidden apps transulent in Dock
defaults write com.apple.dock showhidden -bool true

# prevent auto-open on new download files in Safari
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# enable baskspace key to navigate to previous page in Safari
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# hide bookmarks sidebar by default in Safari
defaults write com.apple.Safari ShowFavoritesBar -bool false

# add a context menu item for showing the web inspector in web views in Safari
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# add Quit to Finder menubar
defaults write com.apple.finder QuitMenuItem -bool true

# disable Photo from auto-starting when device detected
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# enable debug mode in App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

# dim app icon when hidden in Dock
defaults write com.apple.Dock showhidden -boolean yes

# disable Photo from opening automatically when device connects
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# default 7-col, 5-row
defaults write com.apple.dock springboard-columns -int 9
defaults write com.apple.dock springboard-rows -int 5
defaults write com.apple.dock ResetLaunchPad -bool TRUE;killall Dock

# prevent OS X Help Window from Staying on Top
defaults write com.apple.helpviewer DevMode -bool FALSE

# Reset these processes
for app in Finder Dock Safari; do
  killall "$app" > /dev/null 2>&1
done

echo "*** Remember to Restart the System!!! ***"

# EOF
