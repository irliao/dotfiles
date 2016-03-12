# KWM

## Installation
```
brew install homebrew/binary/kwm
```

## LaunchAgent
Start at login
```
brew services start homebrew/binary/kwm
```

Disable start at login
```
rm ~/Library/LaunchAgents/homebrew.mxcl.kwm.plist
```

## Reload Config
```
kwmc config reload
```

