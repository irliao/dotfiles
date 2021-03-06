#!/bin/bash

HASH="%C(bold yellow)%h%Creset"
AUTHOR_DATE="%Cgreen%ad%Creset" # format respects --date= option
AUTHOR="%Cblue%aN%Creset"
REFS="%C(bold red)%d%Creset"
SUBJECT="%s"

FORMAT="$HASH}$AUTHOR_DATE}$AUTHOR}$REFS $SUBJECT"

ANSI_MAGENTA='\033[35m'
ANSI_RESET='\033[0m'

function pretty_git_log {

     git log --date=short --pretty="format:${FORMAT}%n" $* |
        # Line columns up based on } delimiter
        column -s '}' -t 2> /dev/null |
        # Color merge commits specially
        sed -Ee "s/(Merge .*$)/$(printf $ANSI_MAGENTA)\1$(printf $ANSI_RESET)/" |
        # Page only if needed
        less -FXRS
}

function pretty_git_log_stats {

     git log --date=short --pretty="format:${FORMAT}" --stat $* |
        sed 's/}/ /g' |
        # indent stats by a tab for readability
        sed 's/^ /	/g' |
        sed -Ee "s/(Merge .*$)/$(printf $ANSI_MAGENTA)\1$(printf $ANSI_RESET)/" |
        less -FXRS
}
