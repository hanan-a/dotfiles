local wezterm = require 'wezterm'
return {
	-- default_prog = { '/opt/homebrew/bin/fish', '-l' },
	-- color_scheme = 'termnial.sexy',
	color_scheme = 'Catppuccin Mocha',
	-- color_scheme = 'Eldritch',
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
