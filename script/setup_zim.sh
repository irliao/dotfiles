#!/bin/sh

# TODO: include setup to change shell to zsh and download Zim
chsh -s /bin/zsh

zdotdir=${HOME}/.dotfiles/zsh/zim

ln -s ${zdotdir}/zimrc.zsh" "${HOME}/.zimrc

ln -s $zdotdir/zlogin.zsh" "${HOME}/.zlogin

ln -s $zdotdir/zshrc.zsh ${HOME}/.zshrc

ln -s $zdotdir/zalias.zsh $HOME/.zalias

ln -s $zdotdir/zfunction.zsh $HOME/zfunction

ln -s $zdotdir/ztmux.zsh $HOME/ztmux

rm $HOME/.zshrc.zwc && echo "Restart Terminal to complete Zim setup"
