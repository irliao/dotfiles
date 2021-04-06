#
# Executes commands at the start of an interactive session started by zshrc.
#

# NOTE: need to prepend 'function' to method definition when an alias exists with the exact same name,
#       thus need to specify function vs alias for the defined name
# useful var: $OSTYPE - Darwin(Mac), Unix, or Linux

# TODO: integrate http://osxdaily.com/2015/06/03/find-detailed-wifi-connection-history-mac-os-x/ as a function
#
# TODO: migrate this to be autoloaded in modules/

# TODO: example code for prompting user input, make a function and integrate it to others as needed
# if ! zplug check --verbose; then
#     printf "Install? [y/N]: "
#     if read -q; then
#         echo; zplug install
#     fi
# fi

# List files on directory change
# same as overriding cd() { builtin cd "$@" && ls && printf ""; }
# function chpwd() {
#   emulate -L zsh
#   ls
# }

# Change directory and list files
# cd() { builtin cd "$@" && ls && printf ""; }

# Change to previous directory and list files
# pd() { cd - && printf ""; }
# pd() { cd - }

# TODO: implement feature described here:
# http://osxdaily.com/2017/05/12/change-all-file-extensions-command-line/

# Open with default when no args
o() {
    if [[ "$#" == 0 ]]; then
        open .
        return "$?"
    fi
    open "$@";
}

# search with find, arg1 - location, arg2 - item name
f() {
    if [[ "$#" == 1 ]]; then
        find "$PWD" -name "$1"
    fi

    if [[ "$#" == 2 ]]; then
        find "$1" -name "$2"
    fi
    return "$?"
}

# tree (installed with HomeBrew), arg1 - path, arg2 - level
t() {
  if [[ "$#" == 2 ]]; then
      tree "$1" -L "$2"
      return "$?"
  fi
  tree "$@"
}

# open with vim
v() {
    if [[ "$#" == 0 ]]; then
        vim .
        return "$?"
    fi
    vim "$@";
}

# open with Editor (mvim)
e() {
    if [[ "$#" == 0 ]]; then
        "$EDITOR" .
        return "$?"
    fi
    "$EDITOR" "$@";
}

# remove all brew installed dependencies and casks
brew-nuke() {
    brew remove --force $(brew list) --ignore-dependencies &&
      brew remove --cask --force $(brew list) --ignore-dependencies &&
      brew cleanup
}

# convert .mmd file to viewable diagrams, requires mmdc installed (npm install -g mermaid.cli)
mmd() {
    if [[ "$#" != 2 ]]; then
      echo 'mmd error: needs 2 args: arg1 - input file (*.mmd), arg2 - output file (*.pdf/svg/png)'
        return "$?"
    fi
    mmdc -i "$1" -o "$2";
}

# sets to the specified jdk version found in /Library/Java/JavaVirtualMachines/
jdk-set-to() {
  version=$1
  export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
  java -version
}

# Pwd prints path replacing /User/userId/... with ~/...
pwd-tilda() {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

# TODO: implement 'sl' function to find more than just directories
# cd to projects directory with Selecta
devs() {
  cd $(find "$DEVPATH" -maxdepth 1 -type d | selecta)
}

# Backup file/directory to /tmp
backup() {
  if [[ "$#" == 0 ]]; then
    cd /tmp
    return "$?"
  fi
  cp -R "$@" /tmp/ &&
    echo "copied to /tmp: $@"
}

# Move files/directory to /tmp or cd to /tmp if no args
tmp() {
  if [[ "$#" == 0 ]]; then
    cd /tmp
    return "$?"
  fi
  mv "$@" /tmp/ &&
    echo "moved to /tmp: $@"
}

# Move files/directory to /tmp or cd to /tmp if no args
trash() {
  if [[ "$#" == 0 ]]; then
    cd ~/.Trash
    return "$?"
  fi
  mv "$@" ~/.Trash &&
    echo "moved to ~/.Trash: $@"
}

# TODO: verify if this works correctly
# ssh wrapper to automatically source bash config file on remote machine
sshs() {
  ssh ${*:1} "cat > /tmp/.bashrc_temp" < ~/.bashrc
  ssh -t ${*:1} "bash --rcfile /tmp/.bashrc_temp ; rm /tmp/.bashrc_temp"
}

# View man page in Preview
pman() { ps=`mktemp -t manpageXXXX`.ps ; man -t $@ > "$ps" ; open "$ps" ; }

# ps with grep
ps-grep() { ps auxwwwh | grep "$@" | grep -v grep }

# Security functions
md5() { echo -n $1 | openssl md5 /dev/stdin }
sha1() { echo -n $1 | openssl sha1 /dev/stdin }
sha256() { echo -n $1 | openssl dgst -sha256 /dev/stdin }
sha512() { echo -n $1 | openssl dgst -sha512 /dev/stdin }
shift13() { echo $1 | tr "A-Za-z" "N-ZA-Mn-za-m" }
shift47() { echo $1 | tr "\!-~" "P-~\!-O" }
encode-url() { python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])" $1 }
decode-url() { python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])" $1 }
encode-aes() { openssl enc -aes-256-cbc -e -in $1 -out "$1.aes" }
decode-aes() { openssl enc -aes-256-cbc -d -in $1 -out "${1%.*}" }

# show password entry dialog
password-entry-dialog() {
  if [[ -z $1 ]]; then
    gui_prompt="Password:"
  else
    gui_prompt="$1"
  fi
  PW=$(osascript <<EOF
  tell application "System Events"
    activate
    text returned of (display dialog "${gui_prompt}" default answer "" with hidden answer)
  end tell
EOF
  )
  echo -n "${PW}"
}

# Show short directory path
swd() { echo "$(pwd | sed -e "s,^$HOME,~,")" }

# Make and go to directory
md() { [[ -n ${1} ]] && mkdir -p ${1} && builtin cd ${1}; }

# ssh inside Tmux split window
tmux-ssh() {
  tmux split-window "ssh $@"
  tmux select-layout even-vertical >/dev/null 2>&1
}

tmux-attach-or-new() {
    if (( $# )); then
        tmux has-session -t "$*" && tmux attach -t "$*" || tmux new-session -s "$*"
    else
        tmux attach || tmux new-session -s default
    fi
}

tmux-showenv() {
  [[ -n $TMUX ]] && export $(tmux showenv | grep --color=never '^[^-]' | xargs)
}

find-files-named() {
  find . -iname "*$1*" ${@:2}
}

find-files-containing() {
  grep "$1" ${@:2} -R .
}

# Find most recently updated file in current directory
find-mru-file() {
    ls -t $* 2> /dev/null | head -n 1
}

untar() {
  if [[ -f $1 ]]; then
    case $1 in
      *.tar.bz2) tar xvjf $1;;
      *.tar.gz) tar xvzf $1;;
      *.tar.xz) tar xvJf $1;;
      *.tar.lzma) tar --lzma xvf $1;;
      *.bz2) bunzip $1;;
      *.rar) unrar $1;;
      *.gz) gunzip $1;;
      *.tar) tar xvf $1;;
      *.tbz2) tar xvjf $1;;
      *.tgz) tar xvzf $1;;
      *.zip) unzip $1;;
      *.Z) uncompress $1;;
      *.7z) 7z x $1;;
      *.dmg) hdiutul mount $1;; # mount OS X disk images
      *) echo "'$1' cannot be extracted via >ex<";;
  esac
  else
    echo "'$1' is not a valid file"
  fi
}

ipv() {
  ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
  ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}

ram-used-by-app() {
  local sum
  local items
  local app="$1"
  if [ -z "$app" ]; then
    echo "First argument - pattern to grep from processes"
  else
    sum=0
    for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
      sum=$(($i + $sum))
    done
    sum=$(echo "scale=2; $sum / 1024.0" | bc)
    if [[ $sum != "0" ]]; then
      echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
    else
      echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
    fi
  fi
}

# Open file with default Editor in a new Tmux pane
emux() {
  tmux split-window -h -c "#{pane_current_path}" "vim $@"
}

# Change directory to current Finder folder
cdf() {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]; then
      cd "$target"; pwd
  else
      echo 'No Finder window found' >&2
  fi
}

# TODO: merge the 3 select functions below into 1, use options to control execution
# Show selector for projects in $DEVPATH
select-project() {
  cd $(find $DEVPATH -maxdepth 1 -type d | selecta) # install selecta with brew
}

# Return pid of selected process
select-pid() {
  ps axww -o pid,user,%cpu,%mem,start,time,command | selecta | sed 's/^ *//' | cut -f1 -d' '
}

select-file() {
  ccat $(ls | selecta)
}

ssht(){
  ssh $* -t "tmux attach || tmux || $SHELL"
}

# Get path of frontmost Finder window
finder-path() {
  osascript -e 'tell application "Finder"'\
    -e "if (${1-1} <= (count Finder windows)) then"\
    -e "get POSIX path of (target of window ${1-1} as alias)"\
    -e 'else' \
    -e 'get POSIX path of (desktop as alias)'\
    -e 'end if' \
    -e 'end tell';
}

# Print selected files in Finder
finder-selected() {
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
finder-view() {
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
size() {
  local arg=-khs
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

# check if port is binded already
port-check() {
  # netstat -anp tcp | grep $1; # default port scan
  lsof -i tcp:"$1"; # for osx 10.11 or when netstat does not support -p
}

# Destroy processes on PORT
port-kill() {
  if [ -z "$1" ]; then
    echo "Error: missing arg1 - port number (ex. port-kill 8080)" >&2
    return 1
  fi
  lsof -i TCP:$1 | awk '/LISTEN/{print $2}' | xargs kill -9
}

# Reinitialize the git repo by deleting all commits
git-reinit() {
  if [ ! -d .git ]; then
    echo "Error: current directory is not a git directory, aborting"
    return 1
  fi
  remoteOrigin=$(git config --get remote.origin.url)
  shortDirName=${remoteOrigin##*/}
  backupDir="/tmp/$shortDirName-bak"
  # TODO: warn and prompt for yes/no before continueing
  cp -r $(pwd) "$backupDir" && # backup current directory into /tmp
    echo "backed up $(pwd) to $backupDir"
    rm -rf .git/ &&
    git init &&
    git add . &&
    git commit -m 'first commit' &&
    git remote add origin "$remoteOrigin" &&
    git remote -v &&
    git log &&
    echo "Done: git repo reinitialized - run 'git push --force origin master' to complete"
}

# calculator, prepend 'noglob' to allow * as multiply operator in zsh (calc aliased to use noglob in ~/.zalias)
function calc() {
  # bc -l <<< "scale=4; $*;" # 4 digits precision
  echo "$@" | bc -l # default 20 difigs precision
}

calc-pi() {
  pi=$(echo "scale=10; 4*a(1)" | bc -l) # make $pi accessible in current session
  echo $pi
}

# find a file with a pattern in name:
function ff() {
  find . -type f -iname '*'$*'*' -ls
}

# find a directory with a pattern in name:
function fd() {
  find . -type d -iname '*'$*'*' -ls
}

# TODO: find out how this works differently from mdfind -name or remove if same as ff above
# ff() {
#   find . -iname "*${1:-}*"
# }

# TODO: remove if same as fd above
# fd() {
#     target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
#     if [[ $target != "" ]]; then
#         echo $target | pbcopy && echo $target;
#     else
#         echo 'No Finder window found' >&2
#     fi
# }

cat-copy() { cat "$@" | pbcopy}
echo-copy() { echo "$*" | pbcopy } # copy buffer

# Clear font cache for ALL users
clearFontCache (){
  sudo atsutil databases -removeUser && \
    atsutil server -shutdown && \
    atsutil server -ping
}

battery() {
	bat_perc=$(pmset -g batt | egrep "([0-9]+\%)" -o)
  bat_time=$(pmset -g batt | egrep "([0-9]+\:[0-9]+)" -o)
  echo "Battery Remaining: $bat_perc\% $bat_time Hours"
}

bluetooth() {
  if [[ "$#" == 0 ]]; then
    echo 'bluetooth {0:Off, 1:ON}: $(blueutil --power)'
  fi

  if [[ "$#" == 1 ]]; then
    case "$1" in
      "status") echo 'Bluetooth: {0:Off, 1:On}' && blueutil;;
      "on") blueutil --power 1 && echo 'Bluetooth On.';;
      "off") blueutil --power 0 && echo 'Bluetooth Off.';;
      "restart") blueutil --power 0 && blueutil --power 1 && echo 'bluetooth Restarted';;
      *) echo 'bluetooth: invalid option passed, valid options are: [status, on, off, restart]';;
    esac
  else
    echo 'bluetooth: invalid option(s) passed, valid options are: [status, on, off, restart]'
  fi
}

wifi() {
  if [[ "$#" == 0 ]]; then
    echo 'Wi-Fi: $(airport -I | ag -w SSID)'
  fi

  if [[ "$#" == 1 ]]; then
    case "$1" in
      "status") airport -I;;
      "ls") airport -s;; # list available wifi connections
      "on") networksetup -setairportpower en0 on && echo 'Wi-Fi On.';;
      "off") networksetup -setairportpower en0 off && echo 'Wi-Fi Off.';;
      "restart") networksetup -setairportpower en0 off && networksetup -setairportpower en0 on && echo 'Wi-Fi Restarted';;
      *) echo 'wifi: invalid option passed, valid options are: [status, ls, on, off, restart]';;
    esac
  else
    echo 'wifi: invalid option(s) passed, valid options are: [status, ls, on, off, restart]'
  fi
}

get-up-time() {
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

# TODO: check if each segment is within 0-255
validate-ip() {
  if [[ ! "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "False: $1 is not a valid IP address (incorrect format)"
    return
  fi
  echo "True: $1 is a valid IP address (correct format)"
}

# Get password of currently connected WiFi
wifi-show-network-password() {
	networkSSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}') && \
		echo "$networkSSID" && \
		security find-generic-password -D "AirPort network password" -a $networkSSID -gw
}

colors-show-256-colours () {
  for i in {0..255} ; do
    # both ways to display below should output and behave the same
    printf "\x1b[38;5;${i}mcolour${i}\n"
    # echo -e "\e[38;05;${i}mcolour${i}"
  done
}

# Prints current terminal colors
colors-show-profile() {
    T='gYw'   # The test text
    echo -e "\n                 40m     41m     42m     43m\
    44m     45m     46m     47m";
    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m'\
            '  32m' '1;32m' '  33m' '1;33m' '  34m' '1;34m'\
            '  35m' '1;35m' '  36m' '1;36m' '  37m' '1;37m';
        do FG=${FGs// /}
        echo -en " $FGs \033[$FG  $T  "
        for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
            do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
        done
        echo;
    done
    echo
}

# Checks if machine has TouchBar
has-touchbar() {
  if pgrep "ControlStrip" || pgrep "TouchBarAgent"; then
    echo "True"
    return true
  fi

  echo "False"
  return false
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

# Toggles Single Application mode in High Sierra (clicking app in Dock only shows app's window, hides all others in background)
toggleSingleApplicationMode() {
  is_enabled=$(defaults read com.apple.dock single-app)
  if [[ $is_enabled == 1 ]] then
    defaults write com.apple.dock single-app -bool false;
  else
    defaults write com.apple.dock single-app -bool true;
  fi
  killall Dock;
  is_enabled=$(defaults read com.apple.dock single-app)
  echo "Single Application mode turned: ${is_enabled} (0-Off/1-On)"
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
