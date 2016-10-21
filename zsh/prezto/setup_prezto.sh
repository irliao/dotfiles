#!/bin/sh

# TODO: - refactor entire script for readibility
#		- store a copy of z-files instead of removing them

echo 'Removing existing z-files in $HOME'
rm ~/.zalias
rm ~/.zlogin
rm ~/.zlogout
rm ~/.zpreztorc
rm ~/.zprofile
rm ~/.zshenv
rm ~/.zshrc
rm ~/.zfunction

echo 'Symlinking z-files from zprezto/'
ln -s ~/.dotfiles/zsh/prezto/zalias.zsh ~/.zalias
ln -s ~/.dotfiles/zsh/prezto/zlogin.zsh ~/.zlogin
ln -s ~/.dotfiles/zsh/prezto/zlogout.zsh ~/.zlogout
ln -s ~/.dotfiles/zsh/prezto/zpreztorc.zsh ~/.zpreztorc
ln -s ~/.dotfiles/zsh/prezto/zprofile.zsh ~/.zprofile
ln -s ~/.dotfiles/zsh/prezto/zshenv.zsh ~/.zshenv
ln -s ~/.dotfiles/zsh/prezto/zshrc.zsh ~/.zshrc
ln -s ~/.dotfiles/zsh/prezto/zfunction.zsh ~/.zfunction

echo 'Removing existing z-files in zprezto/runcoms/'
rm ~/.zprezto/runcoms/*

echo 'Symlinking z-files in zprezto/runcoms/'
ln -s ~/.zalias ~/.zprezto/runcoms/zalias
ln -s ~/.zlogin ~/.zprezto/runcoms/zlogin
ln -s ~/.zlogout ~/.zprezto/runcoms/zlogout
ln -s ~/.zpreztorc ~/.zprezto/runcoms/zpreztorc
ln -s ~/.zprofile ~/.zprezto/runcoms/zprofile
ln -s ~/.zshenv ~/.zprezto/runcoms/zshenv
ln -s ~/.zshrc ~/.zprezto/runcoms/zshrc
ln -s ~/.zfunction ~/.zprezto/runcoms/zfunction

echo 'Finished setup_zprezto.sh'
