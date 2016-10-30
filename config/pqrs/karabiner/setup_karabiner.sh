#!/bin/sh

# TODO: refactor to check if file exists before removing private.xml
mv ~/Library/Application\ Support/Karabiner/private.xml ~/Downloads/private-bak.xml &&
    ln -s ~/.dotfiles/karabiner.d/osx10.11/karabiner/private.xml ~/Library/Application\ Support/Karabiner/private.xml;


fPath=${HOME}/.dotfiles/karabiner.d/osx10.11/karabiner/import_karabiner_settings.sh
if [[ -f $fPath ]]; then
	source $fPath
fi

echo "Completed Karabiner setup"
