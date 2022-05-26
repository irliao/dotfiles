# Homebrew

## Bundle (https://github.com/Homebrew/homebrew-bundle)
Install Brewfile
```bash
brew bundle --file $brewfile_path 
```

Generate Brewfile
```bash
brew bundle dump --file $brewfile_path # --force to overwrite Brewfile if exist
```

Check for update to install from Brewfile
```bash
brew bundle check --file $brewfile_path # -- verbose to list all missing dependencies
```
