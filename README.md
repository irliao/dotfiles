# irliao's dotfiles

![screenshot](http://i.imgur.com/BXXPRU3.png)

## Installation

**Warning:** This repository primarily supports macOS Sierra (osx10.12) but should be compatible with earlier versions. Please feel free to report any issue or request for features [here](https://github.com/irliao/dotfiles/issues).

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
* [grip](https://github.com/joeyespo/grip) - preview GitHub Markdown files

### Applications

* [Hammerspoon](https://github.com/Hammerspoon/hammerspoon) - system automation
* [Karabiner-Elements](https://github.com/tekezo/Karabiner-Elements) - keyboard customization

## Tasks

* include screencast (maybe asciinema?)
* add Wiki page
* add Contribution.md
* decide if should add Zim (clone or fork) as a submodule
* choose between using master .gitignore at project root or individual .gitignore at various folders
* write own script (maybe Makefile or Rake) to setup .files and remove dotbot from submodule
* fix shift-Tab issue in iTerm2 (somehow fixed by sourcing ~/.zshrc)
* consider adding badge for build status (https://github.com/badges/shields/blob/master/INSTALL.md)

## License
Copyright (c) 2012-2016 Ian Ryan Liao. Released under the [MIT License][license].

[license]: LICENSE.txt
[readme]: README.md
[wiki]: https://github.com/irliao/dotfiles/wiki
