#!/bin/sh

# @author Ian Ryan Liao

# references:
# https://github.com/zanshin/dotfiles/blob/master/make.sh
# https://github.com/atomantic/dotfiles/blob/master/install.sh

# TODO: investigate why vim highlights certain '(' and ')' in this file

# set directory of this script
dotdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function install() {
  # install brew if not found
  if ! brew_loc="$(type -p "brew")" || [ -z "brew_loc" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && \
      echo 'installed brew'
  fi

  # install brew packages
  brew tap homebrew/bundle &&
    cd "$dotdir/config/brew" &&
    brew bundle &&
    echo 'installed brew packages'

  # install Zim if not found
  zimdir="$HOME/.zim"
  if [ -d "$zimdir" ]; then # is directory or symlink
    if [ -L "$zimdir" ]; then # is symlink
      echo "$zimdir already exists as symlink"
    else # is directory
      echo "$zimdir already exists as directory"
    fi
  else
    # fetch Zim
    git clone --recursive https://github.com/Eriner/zim.git ${ZDOTDIR:-${HOME}}/.zim &&
      chsh -s =zsh &&
      echo 'fetched zim'
  fi

  # symlink zsh files
  zshdir="$dotdir/zsh"
  ln -svf "$zshdir/zalias.zsh" "$HOME/.zalias" &&
    ln -svf "$zshdir/zfunction.zsh" "$HOME/.zfunction" &&
    ln -svf "$zshdir/zimrc.zsh" "$HOME/.zimrc" &&
    ln -svf "$zshdir/zlogin.zsh" "$HOME/.zlogin" &&
    ln -svf "$zshdir/zmux.zsh" "$HOME/.zmux" &&
    ln -svf "$zshdir/zshrc.zsh" "$HOME/.zshrc" &&
    ln -svf "$zshdir/prompts/mingit.zsh" "$HOME/.zprompt" &&
    ln -svf "$HOME/.zprompt" "$zimdir/modules/prompt/functions/prompt_mingit_setup" &&
    echo 'symlinked zsh files'

  # symlink directories
  ln -svf "$dotdir/bin" "$HOME/.bin" &&
    echo 'symlinked bin directory'
  ln -svf "$dotdir/config" "$HOME/.config" &&
    echo 'symlinked config directory'
  ln -svf "$dotdir/config/cheat" "$HOME/.cheat" &&
    echo 'symlinked cheat directory'
  ln -svf "$dotdir/config/grip" "$HOME/.grip" &&
    echo 'symlinked grip directory'

  # symlink git files
  ln -svf "$dotdir/git/gitconfig" "$HOME/.gitconfig" &&
    ln -svf "$dotdir/git/gitignore_global" "$HOME/.gitignore_global" &&
    echo 'symlinked git files'

  # symlink vim files
  ln -svf "$dotdir/vim" "$HOME/.vim" &&
    ln -svf "$dotdir/vim/vimrc.vim" "$HOME/.vimrc" &&
    ln -svf "$dotdir/vim/editorconfig.conf" "$HOME/.editorconfig" &&
    ln -svf "$dotdir/vim/ideavimrc.vim" "$HOME/.ideavimrc" &&
    echo 'symlinked vim files'

  # symlink tmux files
  # ln -svf "$dotdir/tmux" "$HOME/.tmux" &&
  #   ln -svf "$dotdir/tmux/tmux.conf" "$HOME/.tmux.conf" &&
  #   echo 'symlinked tmux files'

  echo 'finished install, starting zim' &&
    source ${ZDOTDIR:-${HOME}}/.zlogin &&
    echo 'restart iTerm2 or Terminal application'

  return 1
}

# TODO: warn user that this script will create and/or overwrite existing symlinks
if [ "$1" == "--force" -o "$1" == "-f" ]; then
  # install;
  echo "Force install currently disabled, please rerun script without --force/-f"
else
  read -p "Install may overwrite existing files. Are you sure? (y/n) " -n 1;
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    install;
  fi;
fi;
unset install;

# scripting notes

# conditional: 1 - true, 0 - false
# exit status: 0 - command execute success, non-0 - command failed
# checks if file is symlink to a directory
# if [[ -L "$file" && -d "$file" ]]

# no quote will expand the variable
# double quotes will expand the variable within
# single quote will not expand, thus print the raw value

#     core symlinks
#     ~/.dotfiles: ''
#     ~/.bin: bin
#     ~/.config: config
#     ~/.cheat: config/cheat
#     ~/.grip: config/grip
#     ~/.editorconfig: vim/editorconfig.conf
#     ~/.gitconfig: git/gitconfig
#     ~/.gitignore_global: git/gitignore_global
#     ~/.go: go
#     ~/.hammerspoon: hammerspoon
#     ~/.ideavimrc: vim/ideavimrc.vim
#     ~/.karabiner.d: karabiner.d
#     ~/.tmux: tmux
#     ~/.tmux.conf: tmux/tmux.conf
#     ~/.vim: vim
#     ~/.vimrc: vim/vimrc.vim
