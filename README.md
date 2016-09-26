# dotfiles

irliao's dotfiles for OSX 10.11

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
Run script to help setup git submodules

```
source script/init.sh
```
Update Git Submodules

```
git submodule foreach git pull origin master
```
Run dotbot's install script

```
source install.sh
```


## Setup

Zsh (remember to provide 'mingit' as a symlinked function to Zim)
```
ln -s ~/.dotfiles/zsh/prompts/mingit.zsh ~/.zim/modules/prompt/functions/prompt_mingit_setup
```

Quick Look Plugins
```
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
```

Homebrew
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
optional, prevent Homebrew analytics from being sent: git config --file="$(brew --repository)/.git/config" --replace-all homebrew.analyticsdisabled true
```

Gem
```
optional, update locally installed Gems: sudo gem update -n /usr/local/bin
```

Tmux
```
brew install tmux
```

Vim
```
brew install vim
ln -s /usr/local/bin/mvim /usr/local/bin/vim
cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer --tern-completer
```

Spacemacs
```
brew tap d12frosted/emacs-plus
brew install emacs-plus --with-cocoa --with-gnutls --with-librsvg --with-imagemagick --with-spacemacs-icon
brew linkapps
optional, get default Spacemacs configs: git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
```


## Frameworks and Package Managers
* [dotbot](https://github.com/anishathalye/dotbot)
* [zim](https://github.com/Eriner/zim)
* [vim-plug](https://github.com/junegunn/vim-plug)
* [tpm](https://github.com/tmux-plugins/tpm)


## TODO:
* hook Zim framework as submodule and maybe rename submodules/ to submodule/ or lib/
* refactor files in script/ to be in bin/
* decide whether to have master .gitignore at project root or individual .gitignore at various folders
* fix shift-Tab issue in iTerm2 (somehow fixed by sourcing ~/.zshrc)
* fix vim auto-complete in prompt sometimes not working (somehow fixed by removing ~/.zcompdump && compinit)


## Authors
* [Ian Ryan Liao](https://github.com/irliao)
