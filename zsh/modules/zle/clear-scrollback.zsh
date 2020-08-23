# Clears both screen and scrollback
#
function _clear-scrollback {
    clear

    if [[ -n "${TMUX}" ]]; then
        if [[ -f /usr/local/bin/tmux ]]; then
            /usr/local/bin/tmux clearhist
        elif [[ -f /usr/bin/tmux ]]; then
            /usr/bin/tmux clearhist
        fi
    elif [[ "${TERM_PROGRAM}" == "iTerm.app" ]]; then
        printf '\e]50;ClearScrollback\a'
    else
        tput reset
    fi

    zle reset-prompt
}
zle -N _clear-scrollback
