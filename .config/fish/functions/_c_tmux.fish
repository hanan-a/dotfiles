function _c_tmux
end

function ta
    # Attach to the tmux session with the given name
    tmux attach -t $1
end

function ts
    # Create a new tmux session with the given name
    tmux new -s $1
end
