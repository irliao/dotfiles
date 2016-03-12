#
# Configurations for oh-my-zsh
#
export ZSH=$HOME/.oh-my-zsh

function battery {
    "~/.bin/battery.sh"
}
alias battery='$(battery)'
# setopt promptsubst
# RPROMPT='$(battery) $'

# source : https://gist.github.com/phette23/5270658
export DISABLE_AUTO_TITLE="true"
precmd() {
  # echo -ne "\e]1;${PWD##*/}\a" # sets the tab title to current dir
  # echo -ne "\e]1;$PWD\a" # sets the tab title to $PWD
  # print -Pn "\e]2;%n@%M | %~\a"
  # echo "${PROMPT}"
}

LANG=en_US.UTF-8
ZSH_THEME=pygmalion # Look in ~/.oh-my-zsh/themes/
DISABLE_AUTO_UPDATE="false" # bi-weekly update if true
DISABLE_LS_COLORS="false"
CASE_SENSITIVE="false"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="mm-dd-yyyy"
# ZSH_TMUX_AUTOSTART="true"

# zsh-completions... help: http://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories
fpath=(/usr/local/share/zsh-completions $fpath) # load our own completion functions

# DO NOT include zsh-completions or zsh-syntax-highlighting... let brew handle it!
plugins=(git osx colorize)

source $ZSH/oh-my-zsh.sh

# Vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode
bindkey -M viins 'jj' vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
# bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# Zsh automatically starts Tmux... http://unix.stackexchange.com/questions/43601/how-can-i-set-my-default-shell-to-start-up-tmux
# if command -v tmux>/dev/null; then
#       [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
# fi
# source ~/.tmux/tmuxinator.zsh

# Aliases
# vim /etc/motd # default login message without hushlogin
# cheatset generate sample.rb # for Dash cheatset
alias unlockLoginWallpaper="sudo chflags nouchg /Library/Caches/com.apple.desktop.admin.png;"
alias lockLoginWallpaper="sudo chflags uchg /Library/Caches/com.apple.desktop.admin.png;"
alias speedUpTerminal="sudo rm -rf /private/var/log/asl/*.asl;" # http://osxdaily.com/2010/05/06/speed-up-a-slow-terminal-by-clearing-log-files/
alias reportBootTime='sysctl -a |grep kern.boottime'
alias reportWakeReason='syslog |grep -i "Wake reason"'
alias sleep='pmset sleepnow'
alias cpu='top -F -R -o cpu'
alias copypath='pwd|pbcopy'
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias ll="ls -la"
alias fk='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R' # https://github.com/nvbn/thefuck

# Out
alias listDefaultsWrites="history | grep 'defaults write'"
alias listDefaultsDeletes="history | grep 'defaults delete'"
alias listWifi="networksetup -listallhardwareports"

# Save
alias saveDefaultsWrites="listDefaultsWrites ~/.logs/defaults_writes_logs.txt"
alias saveDefaultsDeletes="listDefaultsDeletes ~/.logs/defaults_deletes_logs.txt"
alias exportKarabiner="/Applications/Karabiner.app/Contents/Library/bin/karabiner export > ~/.pqrs/karabiner-import.sh"

# Zsh
alias zedit="vim -p ~/.zshenv ~/.zprofile ~/.zshrc ~/.zlogin ~/.zlogout"
alias zsync="source ~/.zshenv; source ~/.zshrc;"
alias zreset="rm ~/.zcompdump*; compinit"
alias zrebuild="rm -f ~/.zcompdump; compinit;" # rebuild zshcompdump
alias zcompfix="sudo chmod -R 755 ./site-functions;" # fix compinit error... need admin!

# Git
alias gitRemote="git remote show;" # display info about this remote name
alias gitInfo="git remote show origin;" # if referential integrity is intact
alias gitUrl="git config --get remote.origin.url;" # if referential integrity is broken

# Tmux
alias tmux='TERM=xterm-256color tmux -2'
alias tmuxinator='TERM=xterm-256color tmuxinator'
alias mux='TERM=xterm-256color mux'
alias tmuxListKeys='tmux list-keys -t vi-copy;' # need to be in tmux session first!

# OSX
alias preferredNetwork="networksetup -listpreferredwirelessnetworks en0" # en0 vs en1
alias randommacaddy="openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'"
alias routerIp='netstat -rn | grep default'
alias motiv="motivate format" # https://github.com/simplyianm/motivate
alias imageOptimAllAsync="open -a ImageOptim *.png" # replace *.png with args
alias imageOptimAllSync="/Applications/ImageOptim.app/Contents/MacOS/ImageOptim *.png"
alias dockShowOnlyActiveOn="defaults write com.apple.dock static-only -bool TRUE; killall Dock"
alias dockShowOnlyActiveOff="defaults write com.apple.dock static-only -bool FALSE; killall Dock"
alias wifi="networksetup -setairportpower en0"
alias cbp="pbpaste|less" # print text on clipboard without pasting
alias dockSetSize="defaults write com.apple.dock tilesize -int 40" # Change Dock item size to 40 pixels
alias dockNewListViewOn="defaults write com.apple.dock use-new-list-stack -bool YES; killall Dock"
alias dockNewListViewOff="defaults write com.apple.dock use-new-list-stack -bool NO;killall Dock"
alias dockStackHoverOn="defaults write com.apple.dock mouse-over-hilite-stack -boolean yes;killall Dock"
alias screenShotSaveTo="defaults write com.apple.screencapture location ~/Pictures/Screenshots"
alias fileShowExtensionsOn="defaults write NSGlobalDomain AppleShowAllExtensions -bool true"
alias disableNotificationCenter="launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist"
alias dockShowRecentAppsOnLeft="defaults write com.apple.dock persistent-apps -array-add '{ "tile-data" = { "list-type" = 1; }; "tile-type" = "recents-tile"; }' && killall Dock"
alias dockDisableContentChange="defaults write com.apple.Dock contents-immutable -bool yes"
alias dockDisableSizeChange="defaults write com.apple.Dock size-immutable -bool yes"
alias dockDisableAutoHide="defaults write com.apple.Dock position-immutable -bool yes"
alias dockShowRecentAppsOnRight="defaults write com.apple.dock persistent-others -array-add '{"tile-data" = {"list-type" = 1;}; "tile-type" = "recents-tile";}'; killall Dock"
alias showFiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app"
alias hideFiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app"

# Functions
toggleHiddenFiles() {
	STATUS=$"(defaults read com.apple.Finder | grep -m1 'AppleShowAllFiles')" # -m1 stops

	echo $STATUS;

	if [ $STATUS == YES ]; then
		defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app
	else
		defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app
	fi
}

ppid () {
	ps -p ${1:-$$} -o ppid=;
}

mcd () {
  mkdir -p "$@" && eval cd "\"\$$#\"";
}

dash() {
    open "dash://$*"
}

# reverse LS
tail_ls() {
    ls -l "$1" | tail
}

# man in dash
dman() {
    open "dash://man:$*"
}

# print a horizontal rule
rule () {
    # printf -v _hr "%*s" $(tput cols) && echo ${_hr// /${1--}} # bash
    _hr=$(printf "%*s" $(tput cols)) && echo ${_hr// /${1--}} # zsh
}

## Print horizontal ruler with message
rulem ()  {
    if [ $# -eq 0 ]; then
        echo "Usage: rulem MESSAGE [RULE_CHARACTER]"
	return 1
    fi
    # Fill line with ruler character ($2, default "-"), reset cursor, move 2 cols right, print message
    # printf -v _hr "%*s" $(tput cols) && echo -en ${_hr// /${2--}} && echo -e "\r\033[2C$1" # bash
    _hr=$(printf "%*s" $(tput cols) && echo -en ${_hr// /${2--}} && echo -e "\r\033[2C$1") # zsh

}

right (){
    printf '%*s' $(tput cols) "$@"
}

cdf() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    fi
}

# example of how to check if directory exists
# handles symlink and directory
# rm/rmdir only used for demo purposes
example_ln_or_dir() {
    if [ -d "$LINK_OR_DIR" ]; then
        if [ -L "$LINK_OR_DIR" ]; then
            # It is a symlink!
            # Symlink specific commands go here.
            rm "$LINK_OR_DIR"
        else
            # It is a directory!
            # Directory command gos here.
            rmdir "$LINK_OR_DIR"
        fi
    fi
}

# *** Must be at end of this file!!!
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# TAR - tar -cvzf $final_zip_file_name $items_to_zip
# UNTAR - tar -zxvf example.tar.gz
# SCP LOCAL_REMOTE - scp <local file> <remote user>@<remote machine>:<remote path>
# SCP REMOTE_LOCAL - scp <remote user>@<remote machine>:<remote path> <local file>'
# alias adb_ls="adb shell pm list packages"

# EOF