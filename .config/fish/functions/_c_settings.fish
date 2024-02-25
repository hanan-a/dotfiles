function _c_settings
end

function s_dotfiles --description "Opens the dotfiles directory in Neovim"
    cd ~/own/dotfiles && nvim
end

function s_wezterm --description "Opens the wezterm configuration file in Neovim"
    nvim ~/.config/wezterm/wezterm.lua
end

function s_tmux --description "Opens the tmux configuration file in Neovim"
    nvim ~/.config/tmux/tmux.conf
end

function s_zsh --description "Opens the zsh configuration file in Neovim"
    nvim ~/zshrc/.zshrc
end

function s_fish --description "Opens the fish configuration file in Neovim"
    nvim ~/.config/fish/config.fish
end

function s_starship --description "Opens the starship configuration file in Neovim"
    nvim ~/.config/starship/starship.toml
end

function s_nvim --description "Opens the Neovim plugin configuration file in Neovim"
    nvim ~/.config/nvim/lua/core/plugins.lua
end
