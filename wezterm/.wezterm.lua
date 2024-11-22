-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
-- config.font = wezterm.font("MesloLGS Nerd Font Mono")

config.font_size = 18

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.window_background_opacity = 1
config.macos_window_background_blur = 10

-- config.color_scheme_dirs = { ".config/wezterm/" }
-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "Tokyo Night Moon"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"

config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
}

-- and finally, return the configuration to wezterm
return config
