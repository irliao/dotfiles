# TODO: merge with inputrc-complex.sh after cleaning that file up
"\e[A": history-search-backward
"\e[B": history-search-forward
set show-all-if-ambiguous on
set completion-ignore-case on

# Configure option + right arrow to move forward one word in iTerm2
# https://www.gnu.org/software/bash/manual/bashref.html#Commands-For-Moving
"\e\e[C": forward-word

# Configure option + left arrow to move backward one word in iTerm2
# https://www.gnu.org/software/bash/manual/bashref.html#Commands-For-Moving
"\e\e[D": backward-word

# Auto-completion with Tab
TAB: menu-complete
