#
#
# Executes commands at the start of an interactive session started by zshrc.
#

# useful var: $OSTYPE - Darwin(Mac), Unix, or Linux

# List files on directory change
# same as overriding cd() { builtin cd "$@" && ls && printf ""; }
# function chpwd() {
#   emulate -L zsh
#   ls
# }

# Change directory and list files
cd() { builtin cd "$@" && ls && printf ""; }

# Change to previous directory and list files
bd() { cd - && printf ""; }

# Change to git root directory
rd() { cd $(git rev-parse --show-cdup); }

# Show short directory path
swd() { echo "$(pwd | sed -e "s,^$HOME,~,")" }

# Make and go to directory
md() { [[ -n ${1} ]] && mkdir -p ${1} && builtin cd ${1}; }

# TODO: rename function
# Opens file with default editor in new Tmux pane
te() {
  tmux split-window -h -c "#{pane_current_path}" "vim $@"
}

ssht(){
  ssh $* -t "tmux attach || tmux || $SHELL"
}

# Get path of frontmost Finder window
finderPath() {
  osascript -e 'tell application "Finder"'\
    -e "if (${1-1} <= (count Finder windows)) then"\
    -e "get POSIX path of (target of window ${1-1} as alias)"\
    -e 'else' \
    -e 'get POSIX path of (desktop as alias)'\
    -e 'end if' \
    -e 'end tell';
}

# Print selected files in Finder
finderSelected() {
    osascript <<EOT
        tell application "Finder"
            set theFiles to selection
            set theList to ""
            repeat with aFile in theFiles
                set theList to theList & POSIX path of (aFile as alias) & "\n"
            end repeat
            theList
        end tell
EOT
}

# Change Finder view to column, icon, or list
# args: $1 - Finder window number, $2 - view type
finderView() {
  osascript -e 'set cwd to do shell script "pwd"'\
    -e 'tell application "Finder"'\
    -e "if (${1-1} <= (count Finder windows)) then"\
    -e "set the target of window ${1-1} to (POSIX file cwd) as string"\
    -e "set the current view of the front Finder window to ${2-column} view"\
    -e 'else' -e "open (POSIX file cwd) as string"\
    -e "set the current view of the front Finder window to ${2-column} view"\
    -e 'end if' -e 'end tell';
}

# Determine size of a file or total size of a directory
fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

takeover() {
    # create a temporary session that displays the "how to go back" message
    tmp='takeover temp session'
    if ! tmux has-session -t "$tmp"; then
        tmux new-session -d -s "$tmp"
        tmux set-option -t "$tmp" set-remain-on-exit on
        tmux new-window -kt "$tmp":0 \
            'echo "Use Prefix + L (i.e. ^B L) to return to session."'
    fi

    # switch any clients attached to the target session to the temp session
    session="$1"
    for client in $(tmux list-clients -t "$session" | cut -f 1 -d :); do
        tmux switch-client -c "$client" -t "$tmp"
    done

    # attach to the target session
    tmux attach -t "$session"
}

# Shows what shell you are currently on
# shell () {
#   ps | grep `echo $$` | awk '{ print $4 }'
# }

# Kill process on port
portslay () {
    kill -9 `lsof -i tcp:$1 | tail -1 | awk '{ print $2;}'`
}

# Destroy processes on PORT
killport() {
  if [ -z "$1" ]; then
    echo "Usage: killPort [numeric port identifier]" >&2
    return 1
  fi
  lsof -i TCP:$1 | awk '/LISTEN/{print $2}' | xargs kill -9
}

# TODO: example code for prompting user input
# if ! zplug check --verbose; then
#     printf "Install? [y/N]: "
#     if read -q; then
#         echo; zplug install
#     fi
# fi

# TODO: fix $dir
# Find file with name in directory
ff() {
	dir=${2:-.} # if $2 else .
	name=${2:-1} # if $2 else $1
	find "$dir" -type f -name "$name"
}

fd() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [[ $target != "" ]]; then
        echo $target | pbcopy && echo $target;
    else
        echo 'No Finder window found' >&2
    fi
}

# Copy/Paste buffer
yy() { echo "$*" | pbcopy }
P() { pbpaste | textutil -convert txt -stdin -stdout -encoding 30 | pbpaste } # paste plain text
p() { echo `pbpaste` } # paste with formats, must use ` instead of ' to execute pbpaste
ywd() { echo $PWD | pbcopy } # Yank current directory path

port() {
  # netstat -anp tcp | grep $1; # default port scan
  lsof -i tcp:$1; # for osx 10.11 or when netstat does not support -p
}

# TODO: include wifi toggling in this function
wifi() {
	/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'
}

showcolors256 () {
    for code in {0..255}
    do
        echo -e "\e[38;05;${code}m $code: Test"
    done
}

# Clear font cache for ALL users
clearFontCache (){
  sudo atsutil databases -removeUser && \
    atsutil server -shutdown && \
    atsutil server -ping
}

# Throw all Downloads to Mac's Trashcan
throw(){
	read  -q "REPLY?Throw all files in Downloads into Trashcan? (y/n) "
	echo  "" # (optional) move to a new line

	if [[ $REPLY =~ ^[Yy]$ ]] then
		mv ~/Downloads/* ~/.Trash/
	    echo "Thrown Downloads into Trashcan"
	fi
}

# Empty Mac's Trashcan
empty(){
	read  -q "REPLY?Empty Trashcan? (y/n) "
	echo  "" # (optional) move to a new line

	if [[ $REPLY =~ ^[Yy]$ ]] then
		rm -rf ~/.Trash/*
	    echo "Emptied Trashcan"
	fi
}

# List all files in Mac's Trasncan
trash(){
	ls -la $HOME/.Trash
}

# Show battery information: remaining percentage and remaining time
getBatteryPercent() {
	bat_perc=$(pmset -g batt | egrep "([0-9]+\%)" -o)
	echo "$bat_perc"
}

getBatteryTime() {
  bat_time=$(pmset -g batt | egrep "([0-9]+\:[0-9]+)" -o)
  echo "$bat_time"
}

getBattery() {
	bat_perc=$(pmset -g batt | egrep "([0-9]+\%)" -o)
  bat_time=$(pmset -g batt | egrep "([0-9]+\:[0-9]+)" -o)
  echo "$bat_perc $bat_time"
}

getUpTime() {
  up_time=$(uptime | cut -d "," -f 3-)
  echo "$up_time"
}

# Get current process id
pid () {
	ps -p ${1:-$$} -o ppid=;
}

# Print a horizontal ruled line
line () {
    # printf -v _hr "%*s" $(tput cols) && echo ${_hr// /${1--}} # bash
    _hr=$(printf "%*s" $(tput cols)) && echo ${_hr// /${1--}} # zsh
}

# Get password of currently connected WiFi
getWifiPassword() {
	networkSSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}') && \
		echo "$networkSSID" && \
		security find-generic-password -D "AirPort network password" -a $networkSSID -gw
}

# Show/Hide all files in Finder, default: no
showAllFilesInFinder() {
	read  -q "REPLY?show all files in Finder? (requires relaunching Finder)$1? (y/n) "
	echo  "" # (optional) move to a new line

	if [[ $REPLY =~ ^[Yy]$ ]] then
	    defaults write com.apple.finder AppleShowAllFiles YES; killall Finder;
	else
		defaults write com.apple.finder AppleShowAllFiles NO; killall Finder;
	fi

	is_shown=$(defaults read com.apple.finder AppleShowAllFiles)
	echo "all files currently shown in Finder? ${is_shown}"
}

# Toggle Show/Hide all files in Finder
toggleShowAllFilesInFinder() {
	is_shown=$(defaults read com.apple.finder AppleShowAllFiles)

	if [[ $is_shown == "NO" ]] then
		defaults write com.apple.finder AppleShowAllFiles YES; killall Finder;
	else
		defaults write com.apple.finder AppleShowAllFiles NO; killall Finder;
	fi

	is_shown=$(defaults read com.apple.finder AppleShowAllFiles)
	echo "all files currently shown in Finder? ${is_shown}"
}

# Enable/Disable chime when charging
enableChimeWhenCharging() {
	read  -q "REPLY?enable chime when charging?$1? (y/n) "
	echo  "" # (optional) move to a new line

	# paste in Terminal to test hear the chime sound
	# afplay /System/Library/CoreServices/PowerChime.app/Contents/Resources/connect_power.aif

	if [[ $REPLY =~ ^[Yy]$ ]] then
		defaults write com.apple.PowerChime ChimeOnAllHardware -bool true && \
		open /System/Library/CoreServices/PowerChime.app;
	else
		defaults write com.apple.PowerChime ChimeOnAllHardware -bool false && \
		killall PowerChime;
	fi

	# is_enabled is 1 if enabled, 0 if disabled
	is_enabled=$(defaults read com.apple.PowerChime ChimeOnAllHardware)
	echo "chime enabled when charging? ${is_enabled}"
}

# Set screenshots save location
setScreenshotsSaveLocation() {
	if [[ $# != 1 ]] then
		echo "error: setScreenshotsSaveLocation only takes in 1 arg"
		return 1; # error
	fi

	new_loc=$1
	if ! [[ -d $new_loc ]] then
		echo "error: setScreenshotsSaveLocation detected invalid directory: $new_loc"
		return 1; # error
	fi

	defaults write com.apple.screencapture location $new_loc && \
	killall SystemUIServer

	new_loc=$(defaults read com.apple.screencapture location)
	echo "saving screenshots to: ${new_loc}"
}

# Set screenshots save type
setScreenshotsSaveType() {
	if [[ $# != 1 ]] then
		echo "error: setScreenshotsSaveType requires 1 arg"
		return 1; # error
	fi

	new_type=$1
	if [[ $new_type != "png" && $new_type != "bmp" && $new_type != "gif" && \
		  $new_type != "jpg" && $new_type != "jpeg" && $new_type != "pdf" && \
		  $new_type != "tiff" ]] then
		echo "error: setScreenshotsSaveType detected invalid type: $new_type"
		return 1; # error
	fi

	defaults write com.apple.screencapture type -string $new_type && \
	echo "saving screenshots as type: ${new_type}"
}

# Set background of desktop/login screen with file
setBackgroundOf() {
	if [[ $# != 2 ]] then
		echo "error: setBackgroundOf requires 2 args: [desktop, login] FILE_PATH"
		return 1; # error
	fi

	if ! [[ -f $2 ]] then
		echo "error: setBackgroundOf detected invalid file "
		return 1; # error
	fi

	if [[ $1 == "desktop" ]] then
		sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$2'" && \
		killall Dock;
	elif [[ $1 == "login" ]] then
		mv /Library/Caches/com.apple.desktop.admin.png ~/Downloads/com.apple.desktop.admin_bak.png && \
		mv $2 /Library/Caches/com.apple.desktop.admin.png;
	else
		echo "error: setBackgroundOf arg1 not valid"
		return 1; # error
	fi
}

# Get number of files in a path
# args: $1 - full path to the directory to check
getFilesCountInDirectory() {
	dir=${1:-${PWD}} # if $1 else $PWD
	find $dir -type f | wc -l
}

# Reset Finder view option to default via removing all .DS_Store starting at root
resetFinderDefaultViewOption() {
    read -q "REPLY?Reset Finder's Default View Option? (Y/n) "
    echo ""
    if [[ $REPLY =~ ^[Y]$ ]] then
        sudo find / -name .DS_Store -delete; killall Finder;
    fi
}

# Wrapper for youtube-dl to download MP3 file using URL
youtubeDownloadMP3() {
	if [[ $# != 1 ]] then
		echo "error: youtubeDownloadMP3 requires 1 arg"
		return 1;
	fi

	youtube-dl "$1" --extract-audio --audio-format mp3
}

# quickly create an application icon from 1024px master file
makeAppIcon() {
    if [[ -z "$@" ]]; then
        echo "Input file missing"
    else
        filename=${1%.*}
        mkdir $filename.iconset
        sips -z 16 16   $1 --out $filename.iconset/icon_16x16.png
        sips -z 32 32   $1 --out $filename.iconset/icon_16x16@2x.png
        sips -z 32 32   $1 --out $filename.iconset/icon_32x32.png
        sips -z 64 64   $1 --out $filename.iconset/icon_32x32@2x.png
        sips -z 128 128 $1 --out $filename.iconset/icon_128x128.png
        sips -z 256 256 $1 --out $filename.iconset/icon_128x128@2x.png
        sips -z 256 256 $1 --out $filename.iconset/icon_256x256.png
        sips -z 512 512 $1 --out $filename.iconset/icon_256x256@2x.png
        sips -z 512 512 $1 --out $filename.iconset/icon_512x512.png
        cp $1 $filename.iconset/icon_512x512@2x.png
        iconutil -c icns $filename.iconset
        rm -r $filename.iconset
    fi
}

# TODO: refactor to make nyan print to length of screen
# Git Nyan Graph: https://github.com/steckel/Git-Nyan-Graph
# git customization: git log --graph --color --pretty=oneline
nyan() {
  #!/bin/bash
  NYAN_E='\033'
  NYAN_RESET="${NYAN_E}[0m"
  NYAN_BOLD="${NYAN_E}[1m"
  NYAN_CYAN="${NYAN_E}[0;96m"
  NYAN_RED="${NYAN_E}[0;91m"
  NYAN_YELLOW="${NYAN_E}[0;93m"
  NYAN_GREEN="${NYAN_E}[0;92m"

  if [[ $1 = "-alt" ]]; then # alternative
      echo -en $NYAN_RED'`·.,¸,.·*·.'
      echo -e $NYAN_RESET$NYAN_BOLD'╭━━━━╮'$NYAN_RESET
      echo -en $NYAN_YELLOW'`·.,¸,.·*·.'
      echo -e $NYAN_RESET$NYAN_BOLD'|::: /\_/\\'$NYAN_RESET
      echo -en $NYAN_GREEN'`·.,¸,.·*·.'
      echo -e $NYAN_RESET$NYAN_BOLD'|:::( ◕ᴥ◕)'$NYAN_RESET
      echo -en $NYAN_CYAN'`·.,¸,.·*·.'
      echo -e $NYAN_RESET$NYAN_BOLD'u-u━━-u--u'$NYAN_RESET
  else # default
      echo -en $NYAN_RED'-_-_-_-_-_-_-_'
      echo -e $NYAN_RESET$NYAN_BOLD',------,'$NYAN_RESET
      echo -en $NYAN_YELLOW'_-_-_-_-_-_-_-'
      echo -e $NYAN_RESET$NYAN_BOLD'|   /\_/\\'$NYAN_RESET
      echo -en $NYAN_GREEN'-_-_-_-_-_-_-'
      echo -e $NYAN_RESET$NYAN_BOLD'~|__( ^ .^)'$NYAN_RESET
      echo -en $NYAN_CYAN'-_-_-_-_-_-_-'
      echo -e $NYAN_RESET$NYAN_BOLD'""  ""'$NYAN_RESET
  fi
}

# TODO: integrate this function into ~/.bin/hue
# Set PhilipsHue light theme using cURL to send HTTP Put
# args: $1 - theme name
setPhilipsHueTheme() {
	if [[ $# < 1 ]] then
		echo "error: setPhilipsHueTheme requires at least 1 arg"
		return 1;
	fi

 	# WARN: IP/User could change frequently
    hue_ip='http://192.168.1.72';
    hue_user='g687jn8stWJqOnh8B3NVpMdfXoS-FSFN-fTwHfIg';

    # available lights
	hue_url_light1="$hue_ip/api/$hue_user/lights/1/state";
	hue_url_light2="$hue_ip/api/$hue_user/lights/2/state";
	hue_url_light3="$hue_ip/api/$hue_user/lights/3/state";

	if [[ $1 == "off" ]] then
		hue_body_light1='{"on": false,"bri": 254, "hue": 15125, "sat": 133}';
		hue_body_light2='{"on": false,"bri": 163, "hue": 22632, "sat": 254}';
		hue_body_light3='{"on": false,"bri": 163, "hue": 26632, "sat": 254}';
	elif [[ $1 == "home" ]] then
        if [[ $2 == "low" ]] then
            hue_body_light1='{"on": true,"bri": 3, "hue": 15125, "sat": 133}';
		        hue_body_light2='{"on": true,"bri": 2, "hue": 26632, "sat": 254}';
		        hue_body_light3='{"on": true,"bri": 2, "hue": 26632, "sat": 254}';
        else
		    hue_body_light1='{"on": true,"bri": 254, "hue": 15125, "sat": 133}';
		    hue_body_light2='{"on": true,"bri": 163, "hue": 26632, "sat": 254}';
		    hue_body_light3='{"on": true,"bri": 163, "hue": 26632, "sat": 254}';
        fi
	elif [[ $1 == "relax" ]] then
		hue_body_light1='{"on": true,"bri": 144, "hue": 13088, "sat": 213}';
		hue_body_light2='{"on": true,"bri": 144, "hue": 13088, "sat": 213}';
		hue_body_light3='{"on": true,"bri": 144, "hue": 13088, "sat": 213}';
	elif [[ $1 == "sexy" ]] then
		hue_body_light1='{"on": true,"bri": 225, "hue": 45706, "sat": 252}';
		hue_body_light2='{"on": true,"bri": 183, "hue": 704, "sat": 250}';
		hue_body_light3='{"on": true,"bri": 183, "hue": 704, "sat": 250}';
	elif [[ $1 == "study" ]] then
		hue_body_light1='{"on": true,"bri": 219, "hue": 33848, "sat": 44}';
		hue_body_light2='{"on": true,"bri": 219, "hue": 33848, "sat": 44}';
		hue_body_light3='{"on": true,"bri": 219, "hue": 33848, "sat": 44}';
	elif [[ $1 == "candy" ]] then
		hue_body_light1='{"on": true,"bri": 254, "hue": 16198, "sat": 59}';
		hue_body_light2='{"on": true,"bri": 238, "hue": 25653, "sat": 254}';
		hue_body_light3='{"on": true,"bri": 254, "hue": 14738, "sat": 153}';
	else
		echo "error: setPhilipsHueTheme did not recognize theme: $1"
		return 1;
	fi

	curl -H "Content-Type: application/json" -X PUT -d $hue_body_light1 $hue_url_light1;
	curl -H "Content-Type: application/json" -X PUT -d $hue_body_light2 $hue_url_light2;
	curl -H "Content-Type: application/json" -X PUT -d $hue_body_light3 $hue_url_light3;
}

# TODO: implement
# osxDnsReset() {
# # TODO: should use different commands based on different versions
#   sudo killall -HUP mDNSResponder # 10.10.4 or later:
#   sudo discoveryutil mdnsflushcache # 10.10 ~ 10.10.3:
#   sudo killall -HUP mDNSResponder # 10.7 ~ 10.9.5:
#   sudo dscacheutil -flushcache # 10.6 ~ 10.6.8:
# }

# TODO: implement
alias vimPerfTest="vim --startuptime ${HOME}/.vim/startup_perf.log +q && cat ${HOME}/.vim/startup_perf.log"
# alias resetlaunchpad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
# alias wd="wget --mirror --convert-links --adjust-extension --page-requisites --no-parent" # download webpage

# TODO: implement wifi()
alias wifiOn="networksetup -setairportpower en0 on"
alias wifiOff="networksetup -setairportpower en0 off"
alias wifiHistory="defaults read /Library/Preferences/SystemConfiguration/com.apple.airport.preferences | grep LastConnected -A 7"

# TODO: implement function to save default writes using:
# PROMPT_COMMAND='echo "$(history 1 | grep "defaults write")" | sed '/^$/d' >> ~/Documents/defaults-write.txt'

# TODO: implement this as a function
# Add HiDPI option to System Preferences' Display panel
# sudo defaults write /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled -bool true

# TODO: implement DiskUtils referencing:
# http://osxdaily.com/2015/11/04/verify-repair-permissions-mac-os-x/

# TODO: make this a function
# alias setfindercolumnsview="defaults write com.apple.Finder FXPreferredViewStyle Nlsv;killall Finder" # nlsv - list, icnv - icon, clmv - column, flwv - cover flow
# TODO: implement this function
# Show defaults queried with optional type and/or app name
# showDefaultsUsed() {}

# TODO: make this a function
# alias showdefaults='history | grep "defaults"'
# alias showdefaultswrites='history | grep "defaults write"'
# alias showdefaultsdeletes='history | grep "defaults delete"'
# alias showdefaultsfinder='history | grep "defaults write com.apple.finder"' # can be any app

# TODO: make this a function
# alias osx-set-sleep='pmset schedule sleep "12/24/2009 00:00:00"'
# alias osx-set-wake='pmset schedule wake "12/26/2009 00:00:00"'
# alias osx-log-sleep='syslog |grep -i "Wake reason"'
# alias osx-lidwake='sudo pmset lidwake 0'
# alias osx-set-morning='pmset repeat wakeorpoweron MTWRF 07:45:00'
# alias osx-cancel-morning='pmset repeat cancel'
