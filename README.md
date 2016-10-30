# irliao's dotfiles

![screenshot](http://i.imgur.com/BXXPRU3.png)

## Installation

**Warning:** This repository primarily supports macOS Sierra (osx10.12) but should be compatible with earlier versions. Please feel free to report any issue or request for features [here](https://github.com/irliao/dotfiles/issues).

Clone the repo, ex:

```
git clone https://github.com/irliao/dotfiles $HOME/Developments/dotfiles
```
Run install script inside the repo

```
cd $HOME/Developments/dotfiles && source ./install.sh
```

### Managers

* [dotbot](https://github.com/anishathalye/dotbot) - .files manager
* [zim](https://github.com/Eriner/zim) - Zsh customization and plugin manager
* [vim-plug](https://github.com/junegunn/vim-plug) - Vim plugin manager
* [tpm](https://github.com/tmux-plugins/tpm) - Tmux plugin manager
* [grip](https://github.com/joeyespo/grip) - preview GitHub Markdown files

### Tools

* [Hammerspoon](https://github.com/Hammerspoon/hammerspoon) - system automation

## Tasks

* move karabiner.d/ to be under config/
* finish and test ./install.sh
* include screencast (maybe asciinema?)
* add Wiki page
* add Contribution.md
* choose between using master .gitignore at project root or individual .gitignore at various folders
* investigate shift-Tab issue in iTerm2 (somehow fixed by sourcing ~/.zshrc)
* consider adding badge for build status (https://github.com/badges/shields/blob/master/INSTALL.md)

## License
Copyright (c) 2012-2016 Ian Ryan Liao. Released under the [MIT License][license].

[license]: LICENSE.txt
[readme]: README.md
[wiki]: https://github.com/irliao/dotfiles/wiki
