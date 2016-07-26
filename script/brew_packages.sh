# Example script to install packages with Brew

# vi:ft=ruby:
tap 'homebrew/services'
tap 'homebrew/versions'
tap 'universal-ctags/universal-ctags'

brew 'tmux'
brew 'reattach-to-user-namespace'
brew 'vim'
brew 'ag'
brew 'universal-ctags', args: %w[HEAD]
brew 'bash-completion'
brew 'openssl'
brew 'memcached'
brew 'node'
brew 'redis'
brew 'wget'
brew 'go'
brew 'git'
brew 'hub'
brew 'youtube-dl'
brew 'ffmpeg', args: %w[--with-libvpx --with-libvorbis]

tap 'caskroom/cask'
brew 'caskroom/cask/brew-cask'
cask 'dropbox'
cask '1password'
cask 'spotify'
cask 'iterm2'
cask 'slack'
cask 'alfred'
cask 'charles'
cask 'skype'
cask 'google-chrome'
cask 'caffeine'
cask 'utorrent'
cask 'vlc'
cask 'cathode'

# TODO: refactor
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
