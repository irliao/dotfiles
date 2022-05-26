# Logger Functions

# TODO: refactor the printf messsages

logger-info () {
  printf "  [ \033[00;34m..\033[0m ] %s\n" "$1"
}

logger-user () {
  printf "\r  [ \033[0;33m?\033[0m ] %s" "$1"
}

logger-success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

logger-fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n" "$1"
  echo
  exit
}
