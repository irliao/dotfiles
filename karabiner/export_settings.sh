#!/bin/sh

mv ${HOME}/.dotfiles/karabiner/import_settings.sh ${HOME}/Downloads/karabiner_settings-bak.sh

/Applications/Karabiner.app/Contents/Library/bin/karabiner export > ~/.dotfiles/karabiner/import_settings.sh

echo "Exported Karabiner Setting to ~/.dotfiles/karabiner/import_settings.sh"

# EOF
