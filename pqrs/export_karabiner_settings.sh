#!/bin/sh

[[ -f $HOME/.dotfiles/pqrs/import_karabiner_settings.sh ]] && rm $HOME/.dotfiles/pqrs/import_karabiner_settings.sh

/Applications/Karabiner.app/Contents/Library/bin/karabiner export > ~/.dotfiles/pqrs/import_karabiner_settings.sh

echo "Exported Karabiner Setting to ~/.dotfiles/karabiner/import_karabiner_settings.sh"
