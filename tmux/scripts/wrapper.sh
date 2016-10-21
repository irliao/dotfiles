# source in ~/.bashrc
# https://forums.gentoo.org/viewtopic-t-836006-start-0.html

# Wrapper that prevents Tmux from creating useless sesssions

tmux_nb=`tmux ls | wc -l`
if [[ "$tmux_nb" == "0" ]]; then
    #echo "Launching tmux..."
    tmux
else
    # Make sure we are not already in a tmux session
    if [[ -z "$TMUX" ]]; then
        #echo "tmux already started, attaching..."
        # Session is is date and time to prevent conflict
        session_id=`date +%Y%m%d%H%M%S`
        # Create a new session (without attaching it) and link to session id 0 (to share windows)
        tmux new-session -d -t 0 -s $session_id
        # Create a new window in that session
        tmux new-window
        # Attach to the new session
        tmux attach-session -t $session_id
        # When we detach from it, kill the session
        tmux kill-session -t $session_id
    fi
fi
