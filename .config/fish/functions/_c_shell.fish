function _c_shell
end

function dotfiles --description 'Open dotfiles directory in nvim' --wraps "nvim"
    cd ~/own/dotfiles && nvim .
end

function nvc --description 'Open nvim config directory' --wraps "nvim"
    cd ~/.config/nvim && nvim .
end

function cls --description 'Clear the terminal'
    clear
end

function cl --description 'Clear the terminal'
    clear
end

function xx --description 'Exit the terminal'
    exit
end

function la --description 'List all files' --wraps "eza -al --icons"
    eza $argv -al --icons
end

function ca --description 'Open Cursor-Agent' --wraps "cursor-agent"
    cursor-agent
end

function pd --description 'Go to previous directory'
    prevd
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

function cat --description 'Cat with bat' --wraps "bat"
    bat $argv
end


function lg --description 'lazygit' --wraps "lazygit"
    lazygit
end

function prv --description 'View PR - "gh pr view"' --wraps "gh pr view"
    gh pr view
end

function prs --description 'List PRs - "gh pr list"' --wraps "gh pr list"
    gh pr list
end

function openpr --description 'Open PR - "gh pr view --web"' --wraps "gh pr view --web"
    gh pr view --web
end

function ghd --description 'GH Dash - "gh dash"' --wraps "gh dash"
    gh dash
end

function pversion --description 'Print the package.json version' --wraps "jq"
  if not test -f package.json
    echo "Not in an npm project"
    return 1
  end

  fx '.version' package.json
end

function y --description 'Yazi' --wraps "yazi"
  set tmp (mktemp -t "yazi-cwd.XXXXXX")
  yazi $argv --cwd-file="$tmp"
  if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
    builtin cd -- "$cwd"
  end
  rm -f -- "$tmp"
end


alias sd "cd (fzf --walker dir)"
alias sf "nvim (fzf --preview 'bat -n --color=always {}')"
