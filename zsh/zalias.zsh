#
# Executes commands at the start of an interactive session started by zshrc.
#

# File Editors/Viewers
alias vi="vim -X" # shorter startup time in terminal (do not connect to X server), ???but window title and clipboard will not be used??? TODO: research why the ??? statement is not true
alias vt="vim -p"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias ql="qlmanage -px &>/dev/null"

# Directories
alias app="cd /Applications"
alias bin="cd $HOME/.bin"
alias dev="cd $DEVPATH" # $DEVPATH defined in ~/.zshrc
alias dot="cd $HOME/.dotfiles"
alias dow="cd $HOME/Downloads"
alias doc="cd $HOME/Documents"
alias icl="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs"
alias mov="cd $HOME/Movies"
alias mus="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/Music"
alias pic="cd $HOME/Pictures"

# SD card
alias sdcards-ls="diskutil list"
alias sdcards-unmount="diskutil unmountDisk /dev/disk2" # eject SD card
alias sdcards-mount="diskutil mountDisk /dev/disk2" # insert SD card

# TODO: integrate required setops for aliases below to work: https://github.com/srsudar/prezto/blob/master/modules/directory/init.zsh
# Directory Stack
# alias d='dirs -v' # show visited directories
# for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Zsh
alias zs="source ~/.zshrc && echo 'zsh: sourced zshrc: ~/.zshrc'"
alias zc="rm $HISTFILE && echo 'zsh: removed $HISTFILE: restart shell to clear history'" # clear history and prompt
alias ze="zmanage info >| $HOME/.dotfiles/zsh/zinfo.txt && echo 'zsh: exported zmanage info to: $HOME/.dotfiles/zsh/zinfo.txt'" # write Zim info to file, '>|' overwrites existing file
alias zdebug="source $HOME/.dotfiles/zsh/zdebug.zsh && echo 'zsh: loaded zsh debug utils from sourcing: $HOME/.dotfiles/zsh/zdebug.zsh'" # load the Zsh debugging utils # TODO: convert this into a toggle function
alias zu="zimfw upgrade && zimfw update && echo 'zsh: updated Zim with: zmanage update'" # update Zim

# Python
alias py="python3"

# Find Utilities
alias locate-ignorecase-='locate -i' # -i to make the search case insensitive
alias locate-updatedb="sudo /usr/libexec/locate.updatedb"
alias mdfind-file-with-name="mdfind -name" # searches entire system for file with name
alias mdfind-screenshots-all="mdfind kMDItemIsScreenCapture:1"

# Unix
alias cd-='cd -' # meant to fix typo
alias cd..='cd ..' # meant to surpress error for typo (missing space after cd)
alias dl='curl -O' # pass url as arg1 to download
alias mkdirp='mkdir -p'
alias tailf='tail -f'
alias sudo='sudo ' # make user aliases available for root account
alias s="source"
alias c='clear'
alias ci='clear;echo "Currently logged in on $(tty), as $(whoami) in directory $(pwd)."'
alias lsa='ls -lah'
# alias ls="/bin/ls --color=auto" # only Bash version of ls has --color and -G
# alias ls='/bin/ls -GFh' # override 'ls' with -G colorizes output, -h makes sizes human readable, and -F throws a / after a directory, * after an executable, and a @ after a symlink
alias l="ls -l" # hides ./ and ../ from list
alias la="ls -la" # list all showing units next to sizes and hiding file groups column
alias ls.="ls -d .*" # show only hidden files
alias lt="ls -halt" # Show ls Sort by Date, Human Readable, All Files
alias latest='ls -t | head -n 1' # latest file in folder
alias diff-dirs="diff -qr" # compare 2 input directories
alias qfind='find . -name ' # Quicklook find
alias treef="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'" # tree style ls using find (tree installed from Brew on macOS)
alias mountf='mount | column -t' # show mounts with prettier format
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
alias count-lines="wc -l" # count number of lines in passed in filename or piped buffer
alias sizes="du -sh * | sort -n" # shows all files with size in current directory
alias ..2='cd ../../'
alias ..3='cd ../../../'
alias ..4='cd ../../../../'
alias -g ...='cd ../..' # aliases with -g will get expanded even inside commands
alias -g ....='cd ../../..'
alias -g .....='cd ../../../..'
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....='cd ../../../../'

# Chmod wrapper
# alias rw-='chmod 600'
# alias rwx='chmod 700'
# alias r--='chmod 644'
# alias r-x='chmod 755'

# Zsh options
alias zsh-opts-enabled='setopt'
alias zsh-opts-disabled='unsetopt'

# Bash options
alias bashopts-ls="echo $SHELL | grep bash && shopt -p || echo 'Not Bash, run: <setopt> instead'"

# System info
alias mem-info='free -m -l -t' # pass options to free
alias ps-mem='ps -axf | sort -nr -k 4' # get top process by memory usage
alias ps-mem10='ps -axf | sort -nr -k 4 | head -10'
alias ps-cpu='ps -axf | sort -nr -k 3' # get top process by cpu usage
alias ps-cpu10='ps -axf | sort -nr -k 3 | head -10'
alias cpu-info='lscpu' # get server cpu info

# Override system bins
alias wget='wget -c'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff="colordiff" # diff with colors
alias ag="ag --path-to-ignore=~/.ignore"
# TODO: reenable after figuring out why 'bat' cannot auto complete in zsh
# alias cat="bat" # cat with syntax highlighting
# alias cat-hidden-chars="bat -A" # show and highlight non-printable characters (ex. tabs, spaces, newlines)

# Default system bins
alias gvi="/usr/bin/vi"
alias gman='/usr/bin/man'
alias gwget="/usr/local/bin/wget"
alias ggrep="/usr/bin/grep"
alias gdiff="/usr/bin/diff"
alias gcat="/bin/cat"
alias gls="/bin/ls"
alias gla="/bin/ls -la"
alias gag="/usr/local/bin/ag"

# HTTP requests with cURL
alias curl-get="curl -i -X GET" # -i to include HTTP-header in output, make GET request
alias curl-post="curl -X POST -d" # -d == --data, command followed by json data, url as args (ex. '{"user":"bob","pass":"123"}' http://hostname/resource)
alias curl-post-file="curl -X POST -f" # -f == --form, command followed by file path, url as args (ex. 'fileupload=@filename.txt' http://hostname/resource)
alias curl-put="curl -X PUT -d" # -d == --data, command followed by json data, url as args (ex. '{"user":"bob","pass":"123"}' http://hostname/resource)
alias curl-fetch-header='curl -I' # get server Headers, takes url as args
alias curl-fetch-header-check-compression='curl -I --compress' # checks if remote server supports gzip / mod_deflate or not, takes url as args

# Clipboard
alias pbunformat="pbpaste | textutil -convert txt -stdin -stdout -encoding 30 | pbcopy"
alias pb-tab-to-pace="pbpaste | expand | pbcopy"
alias pb-sort="pbpaste | sort | pbcopy"
alias pb-dedup="pbpaste | uniq | pbcopy"
alias pb-sort-dedup="pbpaste | sort | uniq | pbcopy"
alias pwdc="pwd | tr -d '\n' | pbcopy"

# Miscellaneous
alias calc="noglob calc" # calc() defined in ~/.zfunction, prepend 'noglob' so * is interpreted as multiply operator in zsh
alias psaux="ps aux"
alias pag="ps aux | ag"
alias hammerspoon="/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/ipc/bin/hs" # redefined in case 'http-server' installed from brew overrides this
alias fman='apropos' # man page index search for string match
alias term-size='stty size' # print size of current Terminal as: row col
alias mirrorsite='wget -m -k -K -E -e robots=off' # mirror a website
alias peek='tee >(cat 1>&2)' # mirror stdout to stderr, useful for seeing data going through a pipe
alias speedtest='curl -o /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip' # curl -o == wget -O
alias notify='terminal-notifier -message'
alias shlint-sh='shellcheck'
alias unrar-multipart='unrar x -e' # pass in first/beginning part's file as arg1, install from Brew

# Brew
alias bu="brew update && brew upgrade && brew cleanup && brew doctor"
alias bl="brew leaves" # show formulas not dependencies of another installed formula
alias bls="brew list"
alias brm="brew rmtree" # remove formula with all it's dependencies (brew rm/uninstall only removes the specified formula), requires "brew tap beeftornado/rmtree"
alias brew-config-install="brew bundle --file ~/.dotfiles/config/homebrew/Brewfile" # install configs from Brewfile using brew bundle
alias brew-config-save="brew bundle dump --file ~/.dotfiles/config/homebrew/Brewfile --force" # save current configs to Brewfile using brew bundle
alias brew-config-check="brew bundle check --file ~/.dotfiles/config/homebrew/Brewfile" # list updates from Brewfile using brew bundle
alias brew-cask-search="brew search --cask"
alias brew-nuke="brew remove --force $(brew list) --ignore-dependencies && brew remove --cask --force $(brew list) --ignore-dependencies && brew cleanup"

# alias brew-deps='brew deps --installed --tree' # show installed formulaes' dependencies
# alias brew-uses='brew uses --installed' # show which formuales use $1 as dependency

# Ctags
alias ctags-make="ctags -R ." # creates tags using universal-ctags from brew

# Stack for Haskell
alias ghci="stack --silent ghci --ghci-options -v0" # ghci without loading messages
alias gghci='stack ghci' # default ghci
alias ghc="ghci-color" # ghci-color in ~/.dotfiles/bin, NOTE: do not alias to 'ghci', causes Haskell prompt to halt when printing specific values (ex. [":)"])
# alias sb='stack build' # Stack build

# Maven
alias mvnd="mvnDebug" # runs Maven in debug mode (allows remote debugger to attach at port 8000)
alias mci="mvn clean install"
alias mcid="mvn clean install -DskipTests"
alias mcp="mvn clean package"
alias mcv="mvn clean verify"
alias mct="mvn clean test"
alias mvn-ls-deps="mvn dependency:tree"
alias run-spring="mvn spring-boot:run"

# Node
alias ns="npm start"
alias ni="npm install"
alias nl="npm list --depth=0" # show only top-level modules
alias nlg="npm list -g --depth=0" # show only top-level global modules
alias prettify="prettier --write" # use Prettier (under ./node_modules) to lint/format Javascript file
# alias ni="npm install"
# alias nr="npm run-script"

# Python
alias pip="pip3"
alias pip2="/usr/local/bin/pip" # brew installed Python 2.7
# alias pi='pip install'
# alias piu='pip install --user --install-option="--prefix="' # package-name as arg, mainly for brew installed python puts executable scripts in ~/Library/Python/<X>.<Y>/bin
# alias hass='~/Library/Python/3.6/bin/hass' # TODO: replace 3.6 with current python3 version

# Git
alias ga="git add" # --all stages new in current repo, modified, deleted files; . stages new in current path, modified, deleted files; -u stages modified and deleted without new files
alias gcm="git commit -m"
alias gco="git checkout"
alias gd="git diff --ignore-space-at-eol" # use -w (--ignore-all-space) to ignore all whitespace diffs
alias gdls="git diff --name-only" # show changed files from diff
alias gdum="git diff upstream/master"
alias gf="git fetch"
alias gfu="git fetch upstream"
alias gp="git pull"
alias gpum="git pull upstream master"
alias gr="git rebase"
alias grum="git rebase upstream/master"
alias gl="git log-pretty"
alias gs="git status -sb" # show short status with branch info
alias gt="cd \$(git rev-parse --show-toplevel)" # cd to top level of git directory
alias gw="git-open-cwd" # open current project's web page

# History
alias h="history" # use 1st arg to specify starting index of history
alias ha="history 1" # show all history (1 is the index of first history)
alias hd="dirs -v" # show history of directories visited in current shell session
# alias htop='history | sort -rn | head' # TODO: realias and reenable
alias hg='history 1 | grep' # search for string in history with grep
alias hag='history 1 | ag' # search for string in history with ag

# Youtube
alias yd="youtube-dl"
alias yd-movie="youtube-dl --ignore-errors --output '~/Movies/%(title)s.%(ext)s'" # download video with audio-format defaulted to best, skip unavailable songs when downloading a playlist
alias yd-music="youtube-dl --ignore-errors --extract-audio --audio-format mp3 --output '~/Library/Mobile Documents/com~apple~CloudDocs/Music/New Songs/%(title)s.%(ext)s'" # download audio as mp3 format, skip unavailable videos when downloading a playlist

# TODO: add aliases/functions to control AirDrop

# Weather
alias weather="curl 'wttr.in/?0'" # show current weather
alias weather-month='curl wttr.in' # shows today, tomorrow, and day-after's weather
alias weather-help='curl wttr.in/:help'

# macOS
# TODO: verify if 'make-finder-alias' creates Finder Alias that's compatible with iTunes
alias top-cpu='top -o cpu' # sort by cpu
alias top-mem='top -o rsize' # sort by memory
alias getmod="stat -f %A" # prints the permission of $1 in octal
alias finder-utils"cd /System/Library/CoreServices/Finder.app/Contents/Applications/"
alias make-finder-alias='mkalias -c' # -c omit copying source file's icon to target alias, requires 'osxutils' from Brew, creates a macOS Finder Alias (similar, but not same as soft/hard symlinks)
alias hide='chflags hidden' # make file/dir invisible in Finder (still visible in shell)
alias unhide='chflags nohidden' # make file/dir visible in Finder (still visible in shell)
alias sudo-='sudo $SHELL -c "$(fc -ln -1)"'
alias quit-all="open ~/.dotfiles/config/macos/QuitAll.app" # quits all active applications
alias paths-env='env | grep PATH'
alias battery-settings='pmset -g'
alias dns-clear-local-cache="sudo killall -HUP mDNSResponder"
alias clear-dir-acls="sudo chmod -RN" # clear ACLs for passed in path to folder
alias ip="ipconfig getifaddr en0" # wifi (en1) or ethernet (en0), use en0 if not wired connection
alias ip-lan="ipconfig getifaddr en1" # usually wifi
alias ip-external="curl ifconfig.me"
alias password-generate-secure-to-clipboard="LC_ALL=C tr -dc \"[:alpha:][:alnum:]\" < /dev/urandom | head -c 20 | pbcopy"
alias shutdown="sudo shutdown -h now"
alias restart="sudo shutdown -r now"
alias sip-status="csrutil status" # show System Integrity Protection status
alias restart-notification-center="killall NotificationCenter"
alias clear-asl-logs="sudo rm -rf /private/var/log/asl/*.asl" # clear Apple System Logs to speed up Terminal
alias disks="diskutil list"
alias net="netstat"
alias apps="find /Applications -path '*Contents/_MASReceipt/receipt' -maxdepth 4 -print |\sed 's#.app/Contents/_MASReceipt/receipt#.app#g; s#/Applications/##'" # via find
alias spotlight="mdfind kMDItemAppStoreHasReceipt=1" # via Spotlight
alias plistbuddy="/usr/libexec/PlistBuddy"
alias reload="exec $SHELL -l" # Reload the shell (i.e. invoke as a login shell)
alias power="pmset -g batt"
alias power-remaining="pmset -g ps  |  sed -n 's/.*[[:blank:]]+*\(.*%\).*/\1/p'"
alias power-settings='pmset -g'
alias mute="osascript -e 'set volume output muted true'"
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias screen-saver="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"
alias cpu='top -F -R -o cpu'
alias sleep='pmset sleepnow'
alias airdrop-enable-all="defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true"
alias airdrop-enable="defaults remove com.apple.NetworkBrowser DisableAirDrop"
alias airdrop-disable="defaults write com.apple.NetworkBrowser DisableAirDrop -bool YES"
alias apps-update-all="sudo softwareupdate -ia"
alias apps-update-ls="sudo softwareupdate -l"
alias macos-system-icons="open /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/" # NOTE: .icns in here must be copied to another folder and chmod to 777 to be usable as folder icons

# Time Machine
# alias timemachine="tmutil"
# alias timemachine-set-interval="sudo defaults write /System/Library/LaunchDaemons/com.apple.backupd-auto StartInterval -int" # pass in 1800 for 30 minutes
# alias timemachine-ls="tmutil listbackups"
# alias timemachine-path="tmutil destinationinfo"
# alias timemachine-exclude="sudo tmutil addexclusion" # exclude passed in folder path
# alias timemachine-enable="sudo tmutil enable"
# alias timemachine-disable="sudo tmutil disable"
# alias timemachine-start="tmutil startbackup"
# alias timemachine-stop="tmutil stopbackup"
# alias timemachine-verify-backup-at="sudo tmutil verifychecksums" # verify passed in path to backup
# alias timemachine-status-local-snapshots="defaults read /Library/Preferences/com.apple.TimeMachine MobileBackups"
# alias timemachine-disable-local-snapshots="sudo tmutil disablelocal"
# alias timemachine-enable-local-snapshots="sudo tmutil enablelocal"
# alias timemachine-diff="tmutil calculatedrift" # see deltas for passed in backup folder path

