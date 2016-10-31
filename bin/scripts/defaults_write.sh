#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Build Locate database for locate cli
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

# Disable menu bar transparency
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Enable the 2D Dock
defaults write com.apple.dock no-glass -bool true

# Disable Resume system-wide
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Show remaining battery time; hide percentage
defaults write com.apple.menuextra.battery ShowTime -string "NO"
defaults write com.apple.menuextra.battery ShowPercent -string "NO"

# Disable text manipulations found in System Preferences -> Keyboard -> Text
defaults write com.tapbots.TweetbotMac TextAutomaticQuoteSubstitution -bool NO
defaults write com.tapbots.TweetbotMac TextAutoCorrect -bool NO
defaults write com.tapbots.TweetbotMac TextAutomaticTextReplacement -bool NO

# TODO: removing existing 'NSUserKeyEquivalents' and research on the exact effect of this defaults
# Make CMD-V paste and match format when applicable
# defaults write NSGlobalDomain NSUserKeyEquivalents -dict "Paste and Match Style" -string "@v"

# WARN: sets Capslock to Ctrl... not verified to work yet...
# defaults -currentHost write -g com.apple.keyboard.modifiermapping.alt_handler_id-50 -array "<dict><key>HIDKeyboardModifierMappingDst</key><integer>2</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>"

# WARN: uncomment below to set Launcher grid to 9-col, 4-row
# defaults write com.apple.dock springboard-columns -int 9
# defaults write com.apple.dock springboard-rows -int 4
# defaults write com.apple.dock ResetLaunchPad -bool TRUE;killall Dock

# Make CMD-F in Finder to start "Find by filename"
defaults write com.apple.finder NSUserKeyEquivalents -dict "Find by Name..." -string "@f"

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

# disable two-finger swipe to go back / forward gesture in Google Chrome
defaults write com.google.Chrome.plist
AppleEnableSwipeNavigateWithScrolls -bool FALSE

# use plain text as default format in TextEdit
defaults write com.apple.TextEdit RichText -int 0

# install Command Line Tools without Xcode
# xcode-select --install

# remove All Unavailable Simulators
# xcrun simctl delete unavailable

# make Apple's default Crash Report Screen into Notification
defaults write com.apple.CrashReporter UseUNC 1

# enable debug mode in Safari
defaults write com.apple.Safari IncludeInternalDebugMenu 1

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Disable Safari’s thumbnail cache for History and Top Sites
 defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

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

# disable opening/closing Window animation
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# show scroll bar only when scrolling
defaults write com.apple.Terminal AppleShowScrollbars -string WhenScrolling

# disable animation in Quicklook
defaults write -g QLPanelAnimationDuration -float 0

# enable Save Panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# disable Window animation and Get Info animation in Finder
defaults write com.apple.finder DisableAllAnimations -bool true

# do not animate opening apps from Dock
defaults write com.apple.dock launchanim -bool false

defaults write com.apple.dock expose-animation-duration -float 0.1

# Autohide Dock
defaults write com.apple.dock autohide -bool true

# Remove Dock hide/show delay
defaults write com.apple.dock autohide-delay -float 10000

# Remove Dock hide/show animation
defaults write com.apple.dock autohide-time-modifier -float 0

# disable send/reply animation in Mail
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# show Attachments as Icons
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# reduce render delay in Safari
defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25

# show absolute path in Finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# faster key repeat when held down, set to 0 to try almost instant delete
defaults write NSGlobalDomain KeyRepeat -int 2

# disable Dock hiding animation
defaults write com.apple.Dock autohide-delay -float 0

# change login screen text
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Hello Ian"

# enable subpixel font rendering on non-apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

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

# prevent OS X Help Window from Staying on Top
defaults write com.apple.helpviewer DevMode -bool FALSE

# Install Command Line Tools without Xcode
xcode-select --install

# Remove All Unavailable Simulators
xcrun simctl delete unavailable

# Disable Sudden Motion Sensor... Leaving this turned on is useless when you're using SSDs.
sudo pmset -a sms 0

# upward scrolling gesture to open stacks, same gesture on applications that are running invokes Exposé/Mission Contro
defaults write com.apple.dock scroll-to-open -bool true

# show All File Extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show Full Path in Finder Title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Expand Save Panel by Default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true && \
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Set Current Folder as Default Search Scope
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Set Default Finder Location to Home Folder
defaults write com.apple.finder NewWindowTarget -string "PfLo" && \
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

# Sets Finder sidebar font size to 'small'.
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# disable keyboard autocorrect
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# Enable Chime When Charging
defaults write com.apple.PowerChime ChimeOnAllHardware -bool true && \
	open /System/Library/CoreServices/PowerChime.app

# show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Expand Print Panel by Default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true && \
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Quit Printer App After Print Jobs Complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

### Sudo commands ###

# Disable Sound Effects on Boot
sudo nvram SystemAudioVolume=" "

# Enable Firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# symbolic link to the Airport command, usage: airport -I
sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport

# enable Screensaver Password
defaults write com.apple.screensaver askForPassword -int 1

# enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Reset these processes
for app in Finder Dock Safari; do
  killall "$app" > /dev/null 2>&1
done

echo "*** Remember to Restart the System!!! ***"

### Unused commands ###

# time needed for key repeat to occur, WARN: DO NOT go lower than 5
# defaults write NSGlobalDomain InitialKeyRepeat -int 10
