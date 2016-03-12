#!/bin/sh

# NOTE: > redirects to stdout, >> appends to stdout
#       > also creates file if not there

filePath="${HOME}/.dotfiles/config/packages/gem-packages.txt"
if [[ -f $filePath ]]; then
    rm $filePath
fi
gem --version > $filePath &&
echo 'gem packages: \n' >> $filePath &&
gem list >> $filePath

filePath="${HOME}/.dotfiles/config/packages/brew-packages.txt"
if [[ -f $filePath ]]; then
    rm $filePath
fi
brew --version > $filePath &&
echo 'brew packages: \n' >> $filePath &&
brew list >> $filePath

filePath="${HOME}/.dotfiles/config/packages/npm-packages.txt"
if [[ -f $filePath ]]; then
    rm $filePath
fi
node --version > $filePath &&
npm --version >> $filePath &&
echo 'npm global packages (depth=0): \n' >> $filePath &&
npm list -g --depth=0 >> $filePath

# TODO: pip packages
