#!/bin/sh

rm ${HOME}/.dotfiles/karabiner/import_settings.sh

/Applications/Karabiner.app/Contents/Library/bin/karabiner export > ~/.dotfiles/karabiner/import_settings.sh

echo "Exported Karabiner Setting to ~/.dotfiles/karabiner/import_settings.sh"
