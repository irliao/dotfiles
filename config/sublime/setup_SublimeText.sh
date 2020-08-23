#!/bin/bash

# set -xe # show all commands ran and stop on any error

# If need account (admin) with administrator privilege:
# su admin -c "ln -s /Applications/Sublime\ Text\ 3.app/Contents/SharedSupport/bin/subl /usr/local/bin/sub3;"
# ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

# WARN: - before running this script, rename Sublime Text.app to Sublime Text 3.app
#       - make sure to have reattach-to-user-namespace installed via Brew

# Sublime Text 3
subl_app=/Applications/Sublime\ Text.app
subl_bin=/usr/local/bin/subl
subl_pref=$HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
subl_pkg=$HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings

if [ -e $subl_app ]; then
	# Symlink CLI
    if [ -e $subl_bin ]; then
        rm $subl_bin
    fi
    sudo ln -s $subl_app/Contents/SharedSupport/bin/subl $subl_bin

    # Symlink User preferences
    if [ -e $subl_pref ]; then
    	rm $subl_pref
    fi
    sudo ln -s ~/.dotfiles/config/sublime/Preferences.sublime-settings $subl_pref

    # Symlink list of packages to install with Package Control
    if [ -e $subl_pkg ]; then
    	rm $subl_pkg
    fi
    sudo ln -s ~/.dotfiles/config/sublime/Package\ Control.sublime-settings $subl_pkg

    # Install Nyan Mode with font
    wget https://github.com/wiggin15/SublimeNyan/raw/master/nyan.py -O ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/nyan.py
    wget https://github.com/wiggin15/SublimeNyan/raw/master/Nyan.ttf -O ~/Library/Fonts/Nyan.ttf
fi

# Sublime Text 2
# subl2_app=/Applications/Sublime\ Text\ 2.app
# subl2_bin=/usr/local/bin/subl2
# subl2_pref=~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Preferences.sublime-settings
# subl2_pkg=~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Package\ Control.sublime-settings

# if [ -e $subl2_app ]; then
# 	# Symlink CLI
#     if [ -e $subl2_bin ]; then
#         rm $subl2_bin
#     fi
#     ln -s $subl_app/Contents/SharedSupport/bin/subl $subl2_bin

#     # Symlink User preferences
#     if [ -e $subl2_pref ]; then
#     	rm $subl2_pref
#     fi
#     ln -s ~/.dotfiles/config/sublime/Preferences.sublime2-settings $subl2_pref

#     # Symlink list of packages to install with Package Control
#     if [ -e $subl2_pkg ]; then
#     	rm $subl2_pkg
#     fi
#     ln -s ~/.dotfiles/config/sublime/Package\ Control.sublime2-settings $subl2_pkg
# fi

echo "Finished: setup_SublimeText.sh"

# EOF
