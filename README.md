# dotfiles

irliao's dotfiles

## Installation

Clone the repo

```
git clone https://github.com/irliao/dotfiles ~/Developments/dotfiles
```
Symlink the repo to home directory

```
ln -s ~/Developments/dotfiles ~/.dotfiles
```
Go in the repo and update dotbot

```
cd ~/.dotfiles && git submodule update --remote ./dotbot
```
Run script (init.sh) to setup git submodules

```
./init.sh
```
Run dotbot's install script

```
./install.sh
```


## OSX Setup

Quick Look Plugins
```
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
```


## Homebrew Setup

Paste at Terminal
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Opt out of Analytics by setting this environment variable
```
export HOMEBREW_NO_ANALYTICS=1
```

Prevent Analytics from being sent
```
git config --file="$(brew --repository)/.git/config" --replace-all homebrew.analyticsdisabled true
```


## Tmux Setup

Install Tmux using Brew
```
brew install tmux
```

## Vim Setup 

Install xCode from App Store

Install MacVim using Brew
```
brew install macvim
```

Symlink mvim binary to be vim in /usr/local/bin
```
ln -s /usr/local/bin/mvim /usr/local/bin/vim
```

Install YouCompleteMe for C and JavaScript family
```
cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer --tern-completer
```

## MacDown Setup

Install MacDown using Brew Cask
```
brew cask install macdown
```

Symlink macdown binary to /usr/local/bin
```
ln -s /Applications/MacDown.app/Contents/SharedSupport/bin/macdown /usr/local/bin
```

Import MacDown themes
```
TODO
```

## Spacemacs Setup

Install Spacemacs using Brew
```
brew tap d12frosted/emacs-plus
brew install emacs-plus --with-cocoa --with-gnutls --with-librsvg --with-imagemagick --with-spacemacs-icon
brew linkapps
```

Add Spacemacs to Emacs configuration
```
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
```

## Updating

Dotbot (submodule)
```
git submodule update --remote dotbot
```

Gem
```
sudo gem update -n /usr/local/bin
```


## Frameworks
* [dotbot](https://github.com/anishathalye/dotbot)
* [zim](https://github.com/Eriner/zim)
* [vim-plug](https://github.com/junegunn/vim-plug)
* [tpm](https://github.com/tmux-plugins/tpm)

## Packages
* Homebrew
* Node.js (npm, nvm)
* Python (pip)
* Gem

## Authors
* [Ian Ryan Liao](https://github.com/irliao)

