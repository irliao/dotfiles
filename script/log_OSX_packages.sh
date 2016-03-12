#!/bin/sh

# > redirects to stdout, >> appends to stdout

filePath="~/.dotfiles/config/packages/gem-packages.txt"
echo 'gem packages:' > $filePath &&
gem --version >> $filePath &&
gem list >> $filePath

filePath="~/.dotfiles/config/packages/brew-packages.txt"
echo 'brew packages:' > $filePath &&
brew --version >> $filePath &&
brew list >> $filePath

filePath="~/.dotfiles/config/packages/npm-packages.txt"
echo 'npm packages:' > $filePath &&
node --version >> $filePath &&
npm --version >> $filePath &&
npm list -g >> $filePath

# EOF
