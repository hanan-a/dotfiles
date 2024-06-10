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

function prv --description 'View PR - "gh pr view"'
    gh pr view
end

function prs --description 'List PRs - "gh pr list"'
    gh pr list
end

function openpr --description 'Open PR - "gh pr view --web"'
    gh pr view --web
end

function ghd --description 'GH Dash - "gh dash"'
    gh dash
end

