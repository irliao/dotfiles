#!/bin/sh

[[ -f $HOME/.dotfiles/pqrs/karabiner/import_karabiner_settings.sh ]] && rm $HOME/.dotfiles/pqrs/karabiner/import_karabiner_settings.sh

/Applications/Karabiner.app/Contents/Library/bin/karabiner export > ~/.dotfiles/pqrs/karabiner/import_karabiner_settings.sh

echo "Exported Karabiner Setting to ~/.dotfiles/pqrs/karabiner/import_karabiner_settings.sh"
