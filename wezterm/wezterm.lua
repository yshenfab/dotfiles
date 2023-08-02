-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- start my config
-- config.color_scheme = "GitHub Dark" -- tokyonight_moon
config.color_scheme = "tokyonight_moon" -- tokyonight_moon

config.font = wezterm.font_with_fallback({
	"JetBrains Mono", -- "JetBrainsMonoNL Nerd Font Mono",
	"FiraCode Nerd Font",
	"nonicons",
})

config.font_size = 13.0 -- default 12.0

-- default is true, has more "native" look
config.use_fancy_tab_bar = false

-- no padding around the edges of the terminal area
config.enable_scroll_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.freetype_load_target = "HorizontalLcd"

-- config.window_background_image = '/path/to/wallpaper.jpg'
config.window_background_opacity = 0.8
config.bold_brightens_ansi_colors = true

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 } -- similar to tmux
config.keys = {
	{ mods = "LEADER", key = "|", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "-", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "k", action = wezterm.action.ActivatePaneDirection("Up") },
	{ mods = "LEADER", key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
	{ mods = "LEADER", key = "l", action = wezterm.action.ActivatePaneDirection("Right") },
	{ mods = "LEADER", key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
}

-- end my config

-- and finally, return the configuration to wezterm
return config
