#!/bin/sh

brew install macvim

if [[ -f /usr/local/bin/mvim ]]; then
	ln -s /usr/local/bin/mvim /usr/local/bin/vim
fi

if [[ -d $HOME/.vim/bundle/Vundle.vim ]]; then
	mv $HOME/.vim/bundle/Vundle.vim $HOME/Downloads/Vundle.vim-bak
fi

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall

# install YouCompleteMe for C and JavaScript family
cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer --tern-completer

echo "Finished setting up Vim"

# EOF
