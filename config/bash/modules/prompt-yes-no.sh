#!/usr/local/env bash

# TODO: merge with install.sh to be DRY
prompt-yes-no () {
  local result
  while true; do
    logger-user "$1 [Y/n]: "
    read -rn 1 input

    if [[ $input = Y ]]; then
      echo ""
      result=0
      break
    elif [[ $input = n ]]; then
      echo ""
      result=1
      break
    else
      echo ""
      logger-info "Invalid input ($input). Use Y or n."
      echo ""
    fi
  done

  return $result
}
