# Ruby
reference: https://github.com/Homebrew/homebrew-core/issues/11636

**Use rbenv to install ruby versions, do not install ruby from brew.**

## Installation
Verify if rbenv is properly set up:
```sh
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
```
Use bundler to install Gems
```sh
gem install bundler
```
Reinstall Vim if it won't open and gives errors related to Ruby)
```eh
brew uninstall vim
brew install vim --with-python --with-ruby --with-perl
```

## Upgrading
brew upgrade rbenv ruby-build

## Issues
https://github.com/Homebrew/homebrew-core/issues/11636
If gem commands gives errors like: "...please install libyaml and reinstall your ruby.", try running:
```sh
# https://github.com/Homebrew/homebrew-core/issues/11636
rm -rf /usr/local/lib/ruby/gems/2.4.0/gems/psych-2.2.4
rm -rf /usr/local/lib/ruby/gems/2.4.0/extensions/x86_64-darwin-16/2.4.0/psych-2.2.4
```
or
```sh
rm -rf /usr/local/lib/ruby/gems/
brew uninstall ruby --ignore-dependencies
brew install ruby
```

### Install to local directory
```sh
gem install -n /usr/local/bin <gem_name>
```

### Update all gems on system
```sh
gem update --system
```

### Update locally installed gems
```sh
gem update -n /usr/local/bin
```
