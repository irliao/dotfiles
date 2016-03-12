#!/bin/sh

rm ${HOME}/.dotfiles/karabiner/import_settings.sh

/Applications/Seil.app/Contents/Library/bin/seil export > ~/.dotfiles/karabiner/import_seil_settings.sh
echo "Exported Seil Setting to ~/.dotfiles/karabiner/import_seil_settings.sh"
