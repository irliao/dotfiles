#!/usr/bin/env bash

# TODO: add from: https://ss64.com/osx/syntax-defaults.html
# TODO: integrate http://blog.eriknicolasgomez.com/2016/11/28/managing-or-setting-the-mini-touchbar-control-strip/ to customize TouchBar Control Strip
#
# TODO: research this line and decide if all 'sudo's prepended in some lines are needed
# Ask for the administrator password upfront
sudo -v

# TODO: merge with defaults-write-old.sh then remove it
# TODO: find and fix line causing error: No matching processes belonging to you were found

# TODO: fix error: plist: service already loaded
# Build Locate database for locate cli
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

# sets default save target to be a local disk instead of iCloud
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

# TODO: look into whether Dock actually needs to be unlocked first wheh changing Dock via defaults write below
# Unlock the Dock to accept changes, NOTE: Dock will be locked near the end of this script
defaults write com.apple.Dock contents-immutable -bool false # allow changes to content
defaults write com.apple.Dock size-immutable -bool false # allow changes to size
defaults write com.apple.Dock position-immutable -bool false # allow changtes to position
killall Dock;

# Single Application mode in High Sierra (clicking app in Dock only shows app's window, hides all others in background)
defaults write com.apple.dock single-app -bool true

# Set Dock size
defaults write com.apple.dock tilesize -int 40

# Add a blank space to Dock
# defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type=spacer-tile;}'

# Power button change from entering Stand-by mode to show dialog box
defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool no

# Disable menu bar transparency
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Enable the 2D Dock
defaults write com.apple.dock no-glass -bool true

# Set Dock minimize effect to "Scale effect"
defaults write com.apple.dock mineffect --string scale

# Make Applications minimize to their own icon in Dock
defaults write com.apple.dock minimize-to-application -BOOL YES

# Disable Resume system-wide
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Disable Auto-restore open/unclosed documents in Preview
defaults write com.apple.Preview NSQuitAlwaysKeepsWindows -bool false

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Show remaining battery time; hide percentage
defaults write com.apple.menuextra.battery ShowTime -string "NO"
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# TODO: make a separate defautls script for shortcut mapping
# TODO: add other custom shortcuts to here
defaults write -g NSUserKeyEquivalents -dict-add 'Save As...' '@$s' # maps Save As... to Cmd+Shift+s
defaults write -g NSUserKeyEquivalents -dict-add 'Emoji & Symbols' '\0' # disables the Emoji & Symbols shortcut

# Disable text manipulations found in System Preferences -> Keyboard -> Text
defaults write com.tapbots.TweetbotMac TextAutomaticQuoteSubstitution -bool NO
defaults write com.tapbots.TweetbotMac TextAutoCorrect -bool NO
defaults write com.tapbots.TweetbotMac TextAutomaticTextReplacement -bool NO

# TODO: removing existing 'NSUserKeyEquivalents' and research on the exact effect of this defaults
# Make CMD-V paste and match format when applicable
# defaults write NSGlobalDomain NSUserKeyEquivalents -dict "Paste and Match Style" -string "@v"

# WARN: sets Capslock to Ctrl... not verified to work yet...
# defaults -currentHost write -g com.apple.keyboard.modifiermapping.alt_handler_id-50 -array "<dict><key>HIDKeyboardModifierMappingDst</key><integer>2</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>"

# TODO: warn and prompt user for yes/no before executing lines below since it resets Launcher grid layout completely
# reset Launcher grid to 9-col, 4-row (removes existing application groupings)
# defaults write com.apple.dock springboard-columns -int 9
# defaults write com.apple.dock springboard-rows -int 4
# defaults write com.apple.dock ResetLaunchPad -bool TRUE;killall Dock

# reduce motions and animation of Launchpad
defaults write com.apple.dock springboard-page-duration -float 0

# Make CMD-F in Finder to start "Find by filename"
defaults write com.apple.finder NSUserKeyEquivalents -dict "Find by Name..." -string "@f"

# TODO: ***WARNING*** this line breaks the system (unable to login after restart), fix or remove if not needed
# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write org.x.X11 wm_ffm -bool true
defaults write com.apple.terminal FocusFollowsMouse -string YES

# disable two-finger swipe to go back / forward gesture in Google Chrome
defaults write com.google.Chrome.plist AppleEnableSwipeNavigateWithScrolls -bool FALSE

# use plain text as default format in TextEdit
defaults write com.apple.TextEdit RichText -int 0

# TODO: fix error: xcode-select: error: command line tools are already installed, use "Software Update" to install updates
# Install Command Line Tools without Xcode
xcode-select --install

# remove All Unavailable Simulators
# xcrun simctl delete unavailable

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# make Apple's default Crash Report Screen into Notification
defaults write com.apple.CrashReporter UseUNC 1

# Prevent Time Machine from Prompting to Use New Hard Drives as Backup Volume
sudo defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# enable Debug mode in Contacts
defaults write com.apple.addressbook ABShowDebugMenu -bool true

# enable Debug mode in Safari
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true && \
  defaults write com.apple.Safari IncludeDevelopMenu -bool true && \
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true && \
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true && \
  defaults write -g WebKitDeveloperExtras -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

 # disable Desktop icons from bwing visible (desktop showing large file clusters can slow down a Mac)
defaults write com.apple.finder CreateDesktop -bool false

# save screenshots to ~/Downloads/
defaults write com.apple.screencapture location '~/Downloads/' && \
  killall SystemUIServer

# crash window reports in Notification Center
defaults write com.apple.CrashReporter UseUNC 1

# disable Window resizing Animation speed
defaults write -g NSWindowResizeTime -float 0.001

# show scroll bar only when scrolling in all apps
defaults write -g AppleShowScrollBars -string "WhenScrolling"

# show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# enable key repeat instead of accent key when held down
defaults write -g ApplePressAndHoldEnabled -bool false

# key repeat rate when held down, 0 is fastest
defaults write NSGlobalDomain KeyRepeat -int 2

# disable opening/closing Window animation
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# show scroll bar only when scrolling in Terminal
defaults write com.apple.Terminal AppleShowScrollbars -string "WhenScrolling"

# disable animation in Quicklook
defaults write -g QLPanelAnimationDuration -float 0

# enable Save Panel by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true && \
  defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

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
defaults write com.apple.dock autohide-delay -float 0

# Remove Dock hide/show animation
defaults write com.apple.dock autohide-time-modifier -float 0

# Disable Dashboard completely
defaults write com.apple.dashboard mcx-disabled -boolean true

# disable send/reply animation in Mail
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# show Attachments as Icons
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# reduce render delay in Safari
defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25

# show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# show absolute path in Finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Avoid creating .DS_Store files on USB
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Enable Debug menu in App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

# faster key repeat when held down, set to 0 to try almost instant delete
defaults write NSGlobalDomain KeyRepeat -int 2

# disable Dock hiding animation
defaults write com.apple.Dock autohide-delay -float 0

# Show login screen text
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Device showing this message is owned by Ryan Liao. \n mobile: 858-267-8838 | email: ianryanliao@gmail.com"

# Remove custom message from log in window for shell
# sudo defaults delete /Library/Preferences/com.apple.loginwindow

# enable subpixel font rendering on non-apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# disable rendering delay of webpages in Safari
defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25

# make holding key repeat key normally instead of showing accented key
defaults write -g ApplePressAndHoldEnabled -bool false

# reduce transparency in all
defaults write com.apple.universalaccess reduceTransparency -bool true

# show hidden apps transulent in Dock
defaults write com.apple.dock showhidden -bool YES

# prevent auto-open on new download files in Safari
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# enable baskspace key to navigate to previous page in Safari
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# hide bookmarks sidebar by default in Safari
defaults write com.apple.Safari ShowFavoritesBar -bool false

# add a context menu item for showing the web inspector in web views in Safari
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# add Quit to Finder menubar
defaults write com.apple.finder QuitMenuItem -bool true

# disable Photo from auto-starting when device detected
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# dim app icon when hidden in Dock
defaults write com.apple.Dock showhidden -boolean yes

# prevent OS X Help Window from Staying on Top
defaults write com.apple.helpviewer DevMode -bool FALSE

# Remove All Unavailable Simulators
xcrun simctl delete unavailable

# Disable Sudden Motion Sensor... Leaving this turned on is useless when you're using SSDs.
sudo pmset -a sms 0

# upward scrolling gesture to open stacks, same gesture on applications that are running invokes Exposé/Mission Contro
defaults write com.apple.dock scroll-to-open -bool true

# Fix not working Expose/Mission Control, requires restarting OSX Dock
# defaults write com.apple.dock mcx-expose-disabled -bool FALSE

# show All File Extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show Full Path in Finder Title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Expand Save Panel by Default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Set Current Folder as Default Search Scope
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# sets default Finder folder to Downloads
defaults write com.apple.finder NewWindowTarget -string "PfLo" && \
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"

# Sets Finder sidebar font size to 'small'.
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true

# disable keyboard autocorrect
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable Chime When Charging
# defaults write com.apple.PowerChime ChimeOnAllHardware -bool true && \
# 	open /System/Library/CoreServices/PowerChime.app

# Disable Chime when charging with MagSafe
defaults write com.apple.PowerChime ChimeOnAllHardware -bool false && killall PowerChime

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

# Make Pages open new blank document by default
defaults write com.apple.iWork.Pages NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false

### Sudo commands ###

# Disable Sound Effects on Boot
sudo nvram SystemAudioVolume=" "

# TODO: fix error: Firewall already enabled
# Enable Firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# symbolic link to the Airport command, usage: airport -I
sudo ln -sfh /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport

# enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Lock the Dock from changing, NOTE: should lock Dock only AFTER all the changes to Dock ran, Dock will be unlocked at the top of this script
defaults write com.apple.Dock contents-immutable -bool yes # prevent changes to content
defaults write com.apple.Dock size-immutable -bool yes # prevent changes to size
defaults write com.apple.Dock position-immutable -bool yes # prevent changtes to position
killall Dock;

# Add Stack of recent applications to Dock
# defaults write com.apple.dock persistent-others -array-add '{ "tile-data" = { "list-type" = 1; }; "tile-type" = "recents-tile"; }'

# Use `~/Downloads` to store incomplete downloads
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads"

# Don’t prompt for confirmation before downloading
defaults write org.m0k.transmission DownloadAsk -bool false

# Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

# Hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false
# Hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false

# TODO: uncomment Spotlight block after verifying it, original source: https://github.com/paulmillr/dotfiles/blob/master/etc/osx.sh
# ### Spotlight ###
# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
# sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# defaults write com.apple.spotlight orderedItems -array \
#         '{"enabled" = 1;"name" = "APPLICATIONS";}' \
#         '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
#         '{"enabled" = 1;"name" = "DIRECTORIES";}' \
#         '{"enabled" = 1;"name" = "PDF";}' \
#         '{"enabled" = 0;"name" = "FONTS";}' \
#         '{"enabled" = 0;"name" = "DOCUMENTS";}' \
#         '{"enabled" = 0;"name" = "MESSAGES";}' \
#         '{"enabled" = 0;"name" = "CONTACT";}' \
#         '{"enabled" = 0;"name" = "EVENT_TODO";}' \
#         '{"enabled" = 0;"name" = "IMAGES";}' \
#         '{"enabled" = 0;"name" = "BOOKMARKS";}' \
#         '{"enabled" = 0;"name" = "MUSIC";}' \
#         '{"enabled" = 0;"name" = "MOVIES";}' \
#         '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
#         '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
#         '{"enabled" = 0;"name" = "SOURCE";}'

# # Load new settings before rebuilding the index
# killall mds > /dev/null 2>&1
# # Make sure indexing is enabled for the main volume
# sudo mdutil -i on / > /dev/null
# # Rebuild the index from scratch
# sudo mdutil -E / > /dev/null

# Reset these processes
for app in Finder Dock Safari; do
  kill all"${app}" > /dev/null 2>&1
done

# TODO: uncomment the block below to enable system Restart to apply some changes
# TODO: block below (Restart system) has NOT been ever used/tested, uncomment after verifying it
### Restart system ###
# Wait a bit before moving on...
# sleep 1

# # ...and then.
# echo "Success! Defaults are set."
# echo "Some changes will not take effect until you reboot your machine."

# # See if the user wants to reboot.
# function reboot() {
#   read -p "Do you want to reboot your computer now? (y/N)" choice
#   case "$choice" in
#     y | Yes | yes ) echo "Yes"; exit;; # If y | yes, reboot
#     n | N | No | no) echo "No"; exit;; # If n | no, exit
#     * ) echo "Invalid answer. Enter \"y/yes\" or \"N/no\"" && return;;
#   esac
# }

# # Call on the function
# if [[ "Yes" == $(reboot) ]]
# then
#   echo "Rebooting."
#   sudo reboot
#   exit 0
# else
#   exit 1
# fi

### Unused commands ###

# time needed for key repeat to occur, WARN: DO NOT go lower than 5
# defaults write NSGlobalDomain InitialKeyRepeat -int 10
