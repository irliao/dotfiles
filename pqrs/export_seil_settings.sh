#!/bin/sh

[[ -f $HOME/.dotfiles/pqrs/import_seil_settings.sh ]] && rm ${HOME}/.dotfiles/pqrs/import_seil_settings.sh

/Applications/Seil.app/Contents/Library/bin/seil export > ~/.dotfiles/pqrs/import_seil_settings.sh
echo "Exported Seil Setting to ~/.dotfiles/karabiner/import_seil_settings.sh"
