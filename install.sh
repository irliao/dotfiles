#!/usr/bin/env bash

# set -xe # -x: show every command ran, -e: exit script on any error

# Prettier symlink messages
symlink() {
  ln -svfh  "$1" "$2"
}

# Echo formatted
echof() {
  echo "install.sh: $*" # for shellcheck: $* == $@
}

main() {
  dotfiles_path=~/.dotfiles
  [ ! -d "$dotfiles_path" ] && symlink "$PWD" "$dotfiles_path"

  # install brew if not found
  (! command -v brew > /dev/null) && # checks if brew is installed
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && # downloads brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && # installs brew
      brew analytics off && # opt out of sending Homebrew analytics
      brew doctor &&
      brew update &&
      brew upgrade &&
      echof 'installed brew'

  # install vim (bundled in macvim)
  (! brew ls --version macvim > /dev/null) &&
    brew tap macvim-dev/macvim &&
    brew install --HEAD macvim-dev/macvim/macvim &&
    # symlink /usr/local/Cellar/macvim/*/MacVim.app/ /Applications/ &&
    echof 'installed vim (macvim) with brew'

  # TODO: install and setup ruby with rbenv installed from brew

  # set zsh as default shell (not needed for /bin/zsh because macOS Catalina or newer uses /bin/zsh as default shell)
  zshpath=$(command -v zsh) # detecting which zsh in case using brew installed zsh (/usr/local/bin)
  [ "$SHELL" != "$zshpath" ] &&
    chsh -s "$zshpath" &&
    echof "changed default shell to $zshpath"

  # symlink zsh files
  zshdir=~/.zsh
  symlink "$dotfiles_path/zsh" "$zshdir" &&
    symlink "$zshdir/zalias.zsh" ~/.zalias &&
    # symlink "$zshdir/zbindkey.zsh" ~/.zbindkey &&
    symlink "$zshdir/zshenv.zsh" ~/.zshenv &&
    symlink "$zshdir/zfunction.zsh" ~/.zfunction &&
    symlink "$zshdir/zimrc.zsh" ~/.zimrc &&
    symlink "$zshdir/zlogin.zsh" ~/.zlogin &&
    symlink "$zshdir/zshrc.zsh" ~/.zshrc &&
    symlink "$zshdir/hushlogin.sh" ~/.hushlogin &&
    ln -sfh "$dotfiles_path/config/term/iterm2/iterm2_shell_integration.zsh" ~/.iterm2_shell_integration.zsh

  # symlink miscellaneous directories
  symlink "$dotfiles_path/bin" ~/.bin
  symlink "$dotfiles_path/config" ~/.config

  # symlink grep files
  symlink "$dotfiles_path/config/grep/ignore" ~/.ignore # used by Ag search

  # symlink pip files
  symlink "$dotfiles_path/config/pip" ~/.pip

  # symlink ghci files
  symlink "$dotfiles_path/config/ghc/ghci" ~/.ghci &&
    symlink "$dotfiles_path/config/ghc/haskeline" ~/.haskeline # need to install haskeline with stack

  # symlink vim files
  symlink "$dotfiles_path/vim" ~/.vim &&
    symlink "$dotfiles_path/vim/vimrc.vim" ~/.vimrc &&
    symlink "$dotfiles_path/vim/gvimrc.vim" ~/.gvimrc &&
    symlink "$dotfiles_path/vim/ideavimrc.vim" ~/.ideavimrc &&
    symlink "$dotfiles_path/vim/editorconfig.conf" ~/.editorconfig &&
    symlink "$dotfiles_path/vim/tern-project.json" ~/.tern-project # needed for YCM on JS files

  # symlink tmux files
  symlink "$dotfiles_path/tmux" ~/.tmux &&
    symlink "$dotfiles_path/tmux/tmux.conf" ~/.tmux.conf

  # symlink Hammerspoon configs
  symlink "$dotfiles_path/hammerspoon" ~/.hammerspoon

  # symlink airport utility for macOS
  symlink /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport

  # TODO: add code to check and install fonts in config/macos/fonts/*.ttf for macOS

  # TODO: look into replacing config/homebrew/brewfile.sh + "mas-cli" + "brew cask" with "brew-bundle"
  # TODO: add code to use "mas-cli" or other safe alternatives to install AppStore apps
  # TODO: verify if "Brew Cask" is safest/bestest way to install apps
  # TODO: move this to a new script file in config/homebrew and source the script here
  # install macOS applications not found in the AppStore using Brew Cask
  # [ ! -e /Applications/Google\ Chrome.app ] && brew cask install google-chrome > /dev/null && echof 'cask installed Google Chrome'
  # [ ! -e /Applications/iTerm.app ] && brew cask install iterm2 > /dev/null && echof 'cask installed iTerm'
  # [ ! -e /Applications/Karabiner-Elements.app ] && brew cask install karabiner-elements > /dev/null && echof 'cask installed Karabiner-Elements'
  # [ ! -e /Applications/Hammerspoon.app ] && brew cask install hammerspoon && echof 'cask installed Hammerspoon'
  # [ ! -e /Applications/AppCleaner.app ] && brew cask install appcleaner && echof 'cask installed AppCleaner'

  # user specific instructions
  if ([ "$USER" = 'irliao' ] || [ "$USER" = 'rliao' ]); then
    # symlink git files only for my personal account
      symlink "$dotfiles_path/config/git/gitconfig" ~/.gitconfig &&
        symlink "$dotfiles_path/config/git/gitignore_global" ~/.gitignore_global

    # check and install brew formulas from Brewfile
    homebrew_file="$dotfiles_path/config/homebrew/Brewfile"
    (! brew bundle check --verbose --file "$homebrew_file") &&
      echo "found missing brew formula(s), install with command: brew bundle install --file $homebrew_file"
  fi

  # install zim, needs to install last for sourcing ~/.zlogin
  [ ! -d ~/.zim ] && # test -d for directory or symlink, -L for symlink
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh &&
    source ~/.zlogin && # only needed once during first install
    echof 'downloaded zim to ~/.zim, assuming this is initial install, sourced ~/.zlogin'

  return 0 # install succeeded without error
}

if test "$(uname)" != "Darwin"; then
  echof 'ERROR: currently only support installing on macOS machines'
  exit 1
fi

printf 'install.sh: script may overwrite existing files. Are you sure? (y/Y for YES): '
read -r answer
printf '\n'
case "$answer" in
  y|Y) (main && printf '\n' && echof 'script completed.') || (printf '\n' && echof 'script failed.');;
  *) echof 'script aborted.';;
esac

# unset methods
unset symlink
unset echof
unset main
