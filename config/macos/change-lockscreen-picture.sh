#!/bin/bash

change_lockscreen() {
  local lockscreen_dir=$(ls -d /Library/Caches/Desktop\ Pictures/* |head -n 1)
  local lockscreen_dest="$lockscreen_dir"/lockscreen.png
  local lockscreen_src="$HOME/.dotfiles/config/macos/github_wallpaper.jpg"

  if [[ -f "$lockscreen_dest" ]]; then
    ln -sfh "$lockscreen_src" "$lockscreen_dest" &&
      echo "INFO: successfully symlinked $lockscreen_src to $lockscreen_dest"
  else
    echo "ERROR: $lockscreen_dest does not exist, exiting"
    return 2 # operation not permitted
  fi
}

change_lockscreen
