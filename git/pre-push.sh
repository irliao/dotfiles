#!/bin/sh

source ~/.dotfiles/script/log_packages.sh

git add ~/.dotfiles/config/packages/*.txt

git commit -m "pre-push: adding package log files (.txt)"
