local tokyonight_night = {
  foreground = "#c0caf5",
  background = "#1a1b26",
  cursor_bg = "#c0caf5",
  cursor_border = "#c0caf5",
  cursor_fg = "#1a1b26",
  selection_bg = "#283457",
  selection_fg = "#c0caf5",
  split = "#7aa2f7",
  compose_cursor = "#ff9e64",
  scrollbar_thumb = "#292e42",
  ansi = {
    "#15161e",
    "#f7768e",
    "#9ece6a",
    "#e0af68",
    "#7aa2f7",
    "#bb9af7",
    "#7dcfff",
    "#a9b1d6",
  },
  tab_bar = {
    inactive_tab_edge = "#16161e",
    background = "#1a1b26",
    active_tab = {
      fg_color = "#16161e",
      bg_color = "#7aa2f7",
    },
    inactive_tab = {
      fg_color = "#545c7e",
      bg_color = "#292e42",
    },
    inactive_tab_hover = {
      fg_color = "#7aa2f7",
      bg_color = "#292e42",
      -- intensity = "Bold"
    },
    new_tab_hover = {
      fg_color = "#7aa2f7",
      bg_color = "#1a1b26",
      intensity = "Bold",
    },
    new_tab = {
      fg_color = "#7aa2f7",
      bg_color = "#1a1b26",
    },
  },
}

local wezterm = require 'wezterm'
return {
	-- default_prog = { '/opt/homebrew/bin/fish', '-l' },
	-- color_scheme = 'termnial.sexy',
	-- color_scheme = 'Catppuccin Mocha',
	-- color_scheme = 'Eldritch',
  colors = tokyonight_night,
	enable_tab_bar = false,
  -- font = wezterm.font("FiraCode Nerd Font"),
  font = wezterm.font_with_fallback({
    { family = "JetBrainsMono Nerd Font", scale = 0.75 },
    { family = "FiraCode Nerd Font", scale = 0.75 },
  }),
  font_size = 16.0,
  max_fps = 120,
	-- macos_window_background_blur = 40,
	-- macos_window_background_blur = 30,

	-- window_background_image = '/Users/omerhamerman/Downloads/3840x1080-Wallpaper-041.jpg',
	-- window_background_image_hsb = {
	-- 	brightness = 0.01,
	-- 	hue = 1.0,
	-- 	saturation = 0.5,
	-- },
	-- window_background_opacity = 0.92,
	-- window_background_opacity = 1.0,
	-- window_background_opacity = 0.78,
	-- window_background_opacity = 0.20,
	window_decorations = 'RESIZE',
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
	keys = {
		{
			key = 'f',
			mods = 'CTRL',
			action = wezterm.action.ToggleFullScreen,
		},
    {
      key = 'r',
      mods = 'CMD|SHIFT',
      action = wezterm.action.ReloadConfiguration,
    },
  },
	mouse_bindings = {
	  -- Ctrl-click will open the link under the mouse cursor
	  {
	    event = { Up = { streak = 1, button = 'Left' } },
	    mods = 'CTRL',
	    action = wezterm.action.OpenLinkAtMouseCursor,
	  },
	},
}
