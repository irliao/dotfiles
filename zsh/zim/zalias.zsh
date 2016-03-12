#
# Executes commands at the start of an interactive session started by zshrc.
#

# Editors
alias o="open" 
alias e="subl -w"

# Tmux
alias tks="tmux kill-server"
alias tls="tmux list-sessions"

# Vim
alias vs="vim -O" # vim split vertically
alias vS="vim -o" # vim split horizontally
alias vt="vim -p" # vim with tabs
alias vp="vim --startuptime /tmp/startup.log +q && vim /tmp/startup.log"

# Functions
alias hue="setPhilipsHueTheme"
alias lyn="learnyounode"

# Directory
alias dot="cd ~/.dotfiles"
alias dev="cd ~/Developments"
alias dow="cd ~/Downloads"
alias doc="cd ~/Documents"
alias pic="cd ~/Pictures"
alias app="cd ~/Applications"

# File system
alias la="ls -la"
alias al="ls -lar"
alias sl="ls -r" # ls reverse
alias lr="l -r" # l reverse
alias ll="ls -lh" # ls minimized
alias gg="cd && clear"
alias kk="clear"
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias mkdirP="mkdir -p ~/Downloads/project/{lib/ext,bin,src,doc/{html,info,pdf},demo/stat/a}" # dir cannot contain space char

# Git
alias git="hub"
alias gb="git branch"
alias gs="git status"
alias gc="git clone"
alias gp="git pull"
alias gd="git diff"
alias gl="git log"
alias gr="git remote"
alias gpu="git pull upstream master"
alias glp="git log --oneline --abbrev-commit --all --graph --decorate --color"
alias grs="git reflog show" # show branch activities

# Command line interfaces/tools
alias bu="brew update && brew upgrade && brew prune && brew cleanup && echo 'Brew refreshed'"
alias kb="/Applications/Karabiner.app/Contents/Library/bin/karabiner"
alias kbr="kb reloadxml"
alias kd="ksdiff"
alias md="macdown"
alias se="open -g 'hammerspoon://safari?someParam=openExtensionBuilder'" # open Safari Extension Builder
alias yd="youtube-dl"
alias ydexample="youtube-dl https://www.youtube.com/watch?v=H4ZM-eAfw6c --extract-audio --audio-format mp3"
alias jh="jshint"

# Weather
alias ws="finger o:sandiego@graph.no" # short weather report
alias wf="finger sandiego@graph.no" # full weather report

# History
alias hs="history"
alias historyshowtop15="history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -15"
alias historyshowtopcomplete='history | sort -rn | head'
alias historyclear='history -c'

# Mac OS X
alias ip46="ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'"
alias sleep='pmset sleepnow'
alias cpu='top -F -R -o cpu'
alias showalldisks="diskutil list"
alias ejectalldisks="osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'"
alias resetlaunchpad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
alias testwifi400mb='wget http://cachefly.cachefly.net/400mb.test' # 100/200/400mb speed tests
alias getwifiinfo="airport -I"
alias scanwifiinfo="airport -s"
alias getcomputername="scutil --get ComputerName"
alias getlocalhostname="scutil --get LocalHostName"
alias getboottime='sysctl -a |grep kern.boottime'
alias getwakereason='syslog |grep -i "Wake reason"'
alias getnetworkports='networksetup -listallhardwareports'

# EOF
