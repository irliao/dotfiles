#!/bin/sh

brew remove --force $(brew list) --ignore-dependencies &&
  brew cleanup &&
  echo 'Removed all installed Homebrew packages and unused archives.'
