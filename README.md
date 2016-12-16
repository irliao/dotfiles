# irliao's dotfiles

![screenshot](http://i.imgur.com/qwfYoqP.png)

Total size: **47M**

## Installation

Clone the repo to some path
```bash
git clone https://github.com/irliao/dotfiles $HOME/Developments/dotfiles
```

Run install script inside the repo **Warning:** Script has not been fully tested yet... please read and understand the script PRIOR to executing it.
```bash
cd $HOME/Developments/dotfiles && source ./install.sh
```

## Tools

* [zim](https://github.com/Eriner/zim) - Zsh customization and plugin manager
* [vim-plug](https://github.com/junegunn/vim-plug) - Vim plugin manager
* [Hammerspoon](https://github.com/Hammerspoon/hammerspoon) - system automation for macOS

## Todos

* [ ] write wrapper around hs.window.toggleFullScreen() so exiting out of FullScreen will automatically maximize window
* [ ] reduce size of repo
* [ ] store IntelliJ settings from mbp
* [ ] fix caffeine in Hammerspoon not working on mbp (might need to verify mba)
* [ ] consider adding badge for build status (https://github.com/badges/shields/blob/master/INSTALL.md)
* [ ] fully test and verify ./install.sh
* [ ] remove warnings from Hammerspoon console

## License

Copyright (c) 2012-2016 Ian Ryan Liao. Released under the [MIT License][license].

[license]: LICENSE
[readme]: README.md
[wiki]: https://github.com/irliao/dotfiles/wiki
