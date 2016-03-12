#
# Executes commands at the start of an interactive session started by zshrc.
#

# Set hostname of window in Tmux status bar
# precmd()
# {
#     if [[ ( ${-} == *i* ) && ( ${TERM} == screen* ) ]]
#     then
#         echo -n "\ek$(hostname -s)\e\\"
#     fi
# }
#

# Overriding builtin commands
cd() { builtin cd "$@" && ls && printf ""; }
sd() { echo $PWD | pbcopy }
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
pp() { echo `pbpaste` } # must use ` instead of ' to execute pbpaste

# New/Find file
nn() { touch "$@" }
ff() {
	dir=${2:-.} # if $2 else .
	name=${2:-$1} # if $2 else $1
	find "$dir" -type f -name "$name"
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
bat() {
	bat_perc=$(pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d';');
	bat_time=$(pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f3 -d';');
	echo "Battery Percentage: $bat_perc, Remaining Time: $bat_time"
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

# Set PhilipsHue light theme using cURL to send HTTP Put
# args: $1 - theme name
setPhilipsHueTheme() {
	if [[ $# != 1 ]] then
		echo "error: setPhilipsHueTheme requires 1 arg"
		return 1;
	fi

	hue_url_light1="http://192.168.1.134/api/2c5cc24f5c8b02d630ec33bf6af3c08c/lights/1/state";
	hue_url_light2="http://192.168.1.134/api/2c5cc24f5c8b02d630ec33bf6af3c08c/lights/2/state";
	hue_url_light3="http://192.168.1.134/api/2c5cc24f5c8b02d630ec33bf6af3c08c/lights/3/state";

	if [[ $1 == "off" ]] then
		hue_body_light1='{"on": false,"bri": 254, "hue": 15125, "sat": 133}';
		hue_body_light2='{"on": false,"bri": 163, "hue": 22632, "sat": 254}';
		hue_body_light3='{"on": false,"bri": 163, "hue": 26632, "sat": 254}';
	elif [[ $1 == "forest" ]] then
		hue_body_light1='{"on": true,"bri": 254, "hue": 15125, "sat": 133}';
		hue_body_light2='{"on": true,"bri": 163, "hue": 26632, "sat": 254}';
		hue_body_light3='{"on": true,"bri": 163, "hue": 26632, "sat": 254}';
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

# Reset Finder view option to default via removing all .DS_Store starting at root
resetFinderDefaultViewOption() {
    read -q "REPLY?Reset Finder's Default View Option? (Y/n) "
    echo ""
    if [[ $REPLY =~ ^[Y]$ ]] then
        sudo find / -name .DS_Store -delete; killall Finder;
    fi
}

# TODO: fix $2 == show could actually be show -p, thus changing $#
# Fix Git stash apply stash@{n} being ambiguous for Zsh
# git() {
# 	if [[ $# == 3 && $1 == "stash" && ($2 == "apply" || $2 == "drop" || $2 == "pop" || $2 == "show") ]] then
# 		str=$3 # string "stash@n"
# 		str_pre=$str[1,6]
# 		if [[ $str_pre == "stash@" ]] then
# 			str_len=${#str}
# 			stash_num=$str[7,($str_len)]
# 			/usr/bin/git $1 $2 "stash@{$stash_num}"
# 			return 0;
# 		fi
# 	fi

# 	/usr/bin/git $*
# }

# TODO: implement function to save default writes using:
# PROMPT_COMMAND='echo "$(history 1 | grep "defaults write")" | sed '/^$/d' >> ~/Documents/defaults-write.txt'

# TODO: implement this as a function
# Add HiDPI option to System Preferences' Display panel
# sudo defaults write /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled -bool true

# TODO: implement DiskUtils referencing:
#		http://osxdaily.com/2015/11/04/verify-repair-permissions-mac-os-x/

# TODO: make this a function
# alias setfindercolumnsview="defaults write com.apple.Finder FXPreferredViewStyle Nlsv;killall Finder" # nlsv - list, icnv - icon, clmv - column, flwv - cover flow
# TODO: implement this function
# Show defaults queried with optional type and/or app name
# showDefaultsUsed() {}

# TODO: make this a function
# Defaults
# alias showdefaults='history | grep "defaults"'
# alias showdefaultswrites='history | grep "defaults write"'
# alias showdefaultsdeletes='history | grep "defaults delete"'
# alias showdefaultsfinder='history | grep "defaults write com.apple.finder"' # can be any app

# TODO: make this a function
# Mac OS X
# alias osx-set-sleep='pmset schedule sleep "12/24/2009 00:00:00"'
# alias osx-set-wake='pmset schedule wake "12/26/2009 00:00:00"'
# alias osx-log-sleep='syslog |grep -i "Wake reason"'
# alias osx-lidwake='sudo pmset lidwake 0'
# alias osx-set-morning='pmset repeat wakeorpoweron MTWRF 07:45:00'
# alias osx-cancel-morning='pmset repeat cancel'

# EOF
