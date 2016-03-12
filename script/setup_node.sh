#!/bin/sh

# TODO: script installation for nvm

brew install node

if [ ! -d $HOME/.node_modules_global ]; then
	mkdir $HOME/.node_modules_global
fi

# set npm to install globally to user owned folder to avoid using sudo
npm config set prefix=$HOME/.node_modules_global
