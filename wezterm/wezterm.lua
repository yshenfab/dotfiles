-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- start my config
config.color_scheme = "GitHub Dark" -- tokyonight_moon
-- config.color_scheme = "tokyonight_moon" -- tokyonight_moon

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

config.window_background_opacity = 0.8
config.bold_brightens_ansi_colors = true

-- navigator.nvim, check https://github.com/numToStr/Navigator.nvim/wiki/WezTerm-Integration
local function isViProcess(pane)
	return pane:get_foreground_process_name():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
	if isViProcess(pane) then
		window:perform_action(act.SendKey({ key = vim_direction, mods = "CTRL" }), pane)
	else
		window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
	end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
	conditionalActivatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
	conditionalActivatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
	conditionalActivatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
	conditionalActivatePane(window, pane, "Down", "j")
end)

-- make it similar to my tmux keybindings
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- { mods = "CTRL", key = "h", action = act.ActivatePaneDirection("Left") },
	-- { mods = "CTRL", key = "j", action = act.ActivatePaneDirection("Down") },
	-- { mods = "CTRL", key = "k", action = act.ActivatePaneDirection("Up") },
	-- { mods = "CTRL", key = "l", action = act.ActivatePaneDirection("Right") },
	{ mods = "CTRL", key = "h", action = act.EmitEvent("ActivatePaneDirection-left") },
	{ mods = "CTRL", key = "j", action = act.EmitEvent("ActivatePaneDirection-down") },
	{ mods = "CTRL", key = "l", action = act.EmitEvent("ActivatePaneDirection-right") },
	{ mods = "CTRL", key = "k", action = act.EmitEvent("ActivatePaneDirection-up") },
	{ mods = "ALT",  key = "t", action = act.SpawnTab("CurrentPaneDomain") },
	{ mods = "ALT",  key = "h", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ mods = "ALT",  key = "v", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ mods = "ALT",  key = "1", action = act.ActivateTab(0) },
	{ mods = "ALT",  key = "2", action = act.ActivateTab(1) },
	{ mods = "ALT",  key = "3", action = act.ActivateTab(2) },
	{ mods = "ALT",  key = "4", action = act.ActivateTab(3) },
	{ mods = "ALT",  key = "5", action = act.ActivateTab(4) },
	{ mods = "ALT",  key = "6", action = act.ActivateTab(5) },
	{ mods = "ALT",  key = "7", action = act.ActivateTab(6) },
	{ mods = "ALT",  key = "8", action = act.ActivateTab(7) },
	{ mods = "ALT",  key = "9", action = act.ActivateTab(-1) },
}

-- end my config

-- and finally, return the configuration to wezterm
return config
