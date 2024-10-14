function _c_tmux
end

function ta --description "Attach to a tmux session with the given name" --wraps "tmux attach -t"
    # Attach to the tmux session with the given name
    tmux attach -t $args
end

function ts --description "Creates a new tmux session with the given name" --wraps "tmux new -s"
    # Create a new tmux session with the given name
    tmux new -s $args
end
