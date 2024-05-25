function _c_shell
end

function cls --description 'Clear the terminal'
    clear
end

function xx --description 'Exit the terminal'
    exit
end

function la --description 'List all files'
    eza $argv -al --icons
end

function hosts --description 'Edit hosts file'
    cd ~/../../etc && sudo nvim hosts
end

function compgen --description 'List all commands'
    complete -C
end

function fcompgen --description 'FZF all commands'
    fcomplete
end

function fcomplete --description 'FZF all commands'
    complete -C | fzf
end

function fhis --description 'FZF history'
    history | fzf
end

function cat --description 'Cat with bat'
    bat $argv
end


function lg --description 'lazygit'
    lazygit
end
