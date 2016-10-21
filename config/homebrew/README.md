# Homebrew

## Installation
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
optional, prevent Homebrew analytics from being sent: git config --file="$(brew --repository)/.git/config" --replace-all homebrew.analyticsdisabled true
```


## Homebrew-Bundle (brew package manager)
https://github.com/Homebrew/homebrew-bundle
install: brew tap Homebrew/bundle
list: brew bundle dump [--force]
diff: brew bundle cleanup

## QuickLook plugins installation
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

## Spacemacs installation
brew tap d12frosted/emacs-plus
brew install emacs-plus --with-cocoa --with-gnutls --with-librsvg --with-imagemagick --with-spacemacs-icon
brew linkapps
optional, get default Spacemacs configs: git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
