#!/bin/sh

mv ~/Library/Application\ Support/Karabiner/private.xml ~/Downloads/private-bak.xml &&
    ln -s ~/.dotfiles/pqrs/private.xml ~/Library/Application\ Support/Karabiner/private.xml;

fPath=${HOME}/.dotfiles/pqrs/import_karabiner_settings.sh
if [[ -f $fPath ]]; then
	source $fPath
fi

echo "Completed Karabiner setup"
