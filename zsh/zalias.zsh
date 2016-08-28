#
# Executes commands at the start of an interactive session started by zshrc.
#

# Editors
alias o="open"
alias s="subl -w"
alias v="vim -p"

# Unix
alias c='clear'
alias d='dirs -v'
alias so="source"
alias pbc='pbcopy'
alias pbp='pbpaste'
alias la="ls -la"
alias al="ls -lar"
alias sl="ls -r" # ls reverse
alias lr="l -r" # l reverse
alias ll="ls -FGlAhp" # ls -lh
alias clr='clear;echo "Currently logged in on $(tty), as $(whoami) in directory $(pwd)."'
alias comp="diff -qr" # compare 2 input directories
alias qfind='find . -name '
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias ..4="cd ../../../../"
alias ..5="cd ../../../../../"

# Debug
alias isLoginShell="if [[ -o login ]]; then; print yes; else; print no; fi"
alias fixvim="rm ~/.zcompdump* && compinit"
alias printTmuxPaneSize='tmux list-panes -F "#{pane_width}x#{pane_height}"' # desired window size: x=204, y=64
alias printTmuxCopyModeKeys='tmux list-keys -t vi-copy'
alias printTmuxOptions='tmux show-options -g'
alias enableAutoTmux="ln -s ~/.dotfiles/zsh/zim/ztmux.zsh ~/.ztmux"
alias disableAutoTmux="rm ~/.ztmux && killall tmux"
alias printTmuxColors="source ~/.bin/tmux_colors.sh"
alias printTTYs="ps -a"

# Tmux
alias tmux='TERM=xterm-256color \tmux'
# alias tmk="tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill"
alias tmk="tmux kill-server"
alias tmu="tmux source-file ~/.tmux.conf"
alias getTmuxLayout='tmux list-windows -F "#{window_active} #{window_layout}" | grep "^1" | cut -d " " -f 2'
alias tl="teamocil"
alias tle="teamocil --edit"
alias tll="teamocil --list"
alias tlc="source ~/.tmux/tmux_colors.sh"

# CLIs
alias bu="brew update && brew upgrade && brew prune && brew cleanup && brew doctor"
alias fk='$(thefuck $(fc -ln -1))' # WARN: this alias must use single quotes to work properly
alias ch="cheat"
alias py="python"
alias kd="ksdiff"
alias md="macdown"
alias ns="npm start"
alias yd="youtube-dl" # download YouTube video
alias hue="setPhilipsHueTheme"
alias huehome="setPhilipsHueTheme home"
alias seb="open -g 'hammerspoon://safari?someParam=openExtensionBuilder'" # open Safari Extension Builder using Hammerspoon
alias kbr="/Applications/Karabiner.app/Contents/Library/bin/karabiner reloadxml"
alias sel="/Applications/Seil.app/Contents/Library/bin/seil"
alias cat="ccat" # cat with syntax highlighting
alias nya="nyancat"
alias net="netstat"
alias mirrorsite='wget -m -k -K -E -e robots=off' # mirror a website
alias peek='tee >(cat 1>&2)' # mirror stdout to stderr, useful for seeing data going through a pipe

# Git
alias ga="git add"
alias gb="git branch"
alias gd="git diff"
alias gc="git commit"
alias gl="git log"
alias gm="git standup" # m for morning (standup usually in morning)
alias gp="git pull"
alias gr="git remote"
alias gs="git status"
alias gpu="git pull upstream master"
alias glp="git log --oneline --abbrev-commit --all --graph --decorate --color"
alias grs="git reflog show" # show branch activities

# Directories
alias dot="cd ${HOME}/.dotfiles"
alias dow="cd ${HOME}/Downloads"
alias doc="cd ${HOME}/Documents"
alias mus="cd ${HOME}/Music"
alias pic="cd ${HOME}/Pictures"
alias app="cd ${HOME}/Applications"
alias dev="cd ${DEVPATH}"
alias saf="cd ${DEVPATH}/safari-extensions"
alias web="cd ${DEVPATH}/irliao.github.io"
alias rea="cd ${DEVPATH}/react-tutorials"
alias ghc="cd ${DEVPATH}/clones"
alias bs="cd ~/BitTorrent\ Sync"
alias vm="cd ~/Virtual\ Machines"

# History
alias hs="history"
alias history15="history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -15"
alias historyTop='history | sort -rn | head'
alias historyClear='history -c'

# OSX
alias osxClipboardNoFormat="pbpaste | textutil -convert txt -stdin -stdout -encoding 30 | pbcopy"
alias osxOpeniCloud="cd $HOME/Library/Mobile Documents/com~apple~CloudDocs/"
alias osxResetSpotlight="sudo mdutil -E /" # / can be replaced by any path to volume
alias osxShowSpotlightIndex="sudo mdls /" # / can be replaced by any path to show as root
alias stfu="osascript -e 'set volume output muted true'"
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias reload="exec $SHELL -l" # Reload the shell (i.e. invoke as a login shell)
alias osxVersion="sw_vers"
alias bat="pmset -g batt"
alias osxMakeNewPassword="tr -dc A-Za-z0-9_ < /dev/urandom | head -c 20 | pbcopy"
alias airportcycle='networksetup -setairportpower airport off; networksetup -setairportpower airport on'
alias osxTestBandwidth="wget http://cachefly.cachefly.net/100mb.test -O /dev/null"
alias osxUptime="uptime | cut -d ',' -f 2- | cut -c 1-6"
alias osxEjectAllDisks="osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'"
alias osxListAllDisks="diskutil list"
alias osxWifi="airport -I"
alias osxWifiScan="airport -s"
alias osxCpu='top -F -R -o cpu'
alias osxScreenSaver="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"
alias osxLock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias osxSleep='pmset sleepnow'
alias osxRestart="sudo reboot"
alias osxShutoff="sudo poweroff"
alias osxUpdateApps="sudo softwareupdate -ia"
alias osxAppStoreApps="find /Applications -path '*Contents/_MASReceipt/receipt' -maxdepth 4 -print |\sed 's#.app/Contents/_MASReceipt/receipt#.app#g; s#/Applications/##'"
alias osxCleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
alias osxWeather="finger o:sandiego@graph.no" # short weather report
alias osxWeatherFull="finger sandiego@graph.no" # full weather report
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

