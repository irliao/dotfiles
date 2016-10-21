# irliao's dotfiles

## Installation

Clone the repo to some directory, ex: ~/Developments/

```
git clone https://github.com/irliao/dotfiles ~/Developments/dotfiles
```
Symlink the repo to home directory

```
ln -s ~/Developments/dotfiles ~/.dotfiles
```
Go in the dotfiles repo and update submodule: dotbot

```
cd ~/.dotfiles && git submodule update --remote ./dotbot
```
Update all submodules

```
git submodule foreach git pull origin master
```
Run dotbot's install script

```
source install.sh
```

## Dependencies

### Managers
* [dotbot](https://github.com/anishathalye/dotbot) - .files manager
* [zim](https://github.com/Eriner/zim) - Zsh customization and plugin manager
* [vim-plug](https://github.com/junegunn/vim-plug) - Vim plugin manager
* [tpm](https://github.com/tmux-plugins/tpm) - Tmux plugin manager

### Applications
* [Hammerspoon]() - system automation
* [Karabiner-Elements]() - keyboard customization

## Tasks

* include screenshot and/or screencast (maybe asciinema?)
* add Wiki page
* add Contribution.md
* choose between using master .gitignore at project root or individual .gitignore at various folders
* decide if should add Zim (clone or fork) as a submodule
* fix shift-Tab issue in iTerm2 (somehow fixed by sourcing ~/.zshrc)
* write own script (maybe Makefile or Rake) to setup .files and remove dotbot from submodule
* consider adding badge for build status (https://github.com/badges/shields/blob/master/INSTALL.md)

## License
Copyright (c) 2012-2016 Ian Ryan Liao. Released under the [MIT License][license].

[wiki]: https://github.com/irliao/dotfiles/wiki
[license]: LICENSE.txt
[readme]: README.md
