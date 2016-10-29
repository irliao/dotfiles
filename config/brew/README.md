# Homebrew

## Installation

## Homebrew-Bundle (https://github.com/Homebrew/homebrew-bundle)

install with brew
```bash
brew tap Homebrew/bundle
```

save installed packages into ./Brewfile
```bash
brew bundle dump [--force]
```
remove packages not listed in ./Brewfile
```bash
 brew bundle cleanup
 ```

## Tasks
* merge all Brewfile across devices into single file (current Brewfile only handles irl-mba)
