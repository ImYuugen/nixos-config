local wezterm = require("wezterm")
local act = wezterm.action

local keys = {
  { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
  { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
  -- Tabs
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = act.SpawnTab("DefaultDomain"),
	},
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = act.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "Tab",
		mods = "CTRL",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "Tab",
		mods = "CTRL|SHIFT",
		action = act.ActivateTabRelative(-1),
	},

	-- Panes
	{
		key = [[\]],
		mods = "CTRL|ALT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "|",
		mods = "CTRL|ALT|SHIFT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		-- Space because it's the fastest
		key = "Space",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "pane_control",
			one_shot = false,
			timemout_miliseconds = 1000,
		}),
	},
}

local key_tables = {
  pane_control = {
    -- Navigate
  	{ key = "k", action = act.ActivatePaneDirection("Up") },
  	{ key = "j", action = act.ActivatePaneDirection("Down") },
  	{ key = "h", action = act.ActivatePaneDirection("Left") },
  	{ key = "l", action = act.ActivatePaneDirection("Right") },
    -- Resize
		{ key = "k", mods = "CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "j", mods = "CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "h", mods = "CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "l", mods = "CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
  },
}

local mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
}

return {
	disable_default_key_bindings = true,
	leader = { key = "Space", mods = "CTRL|ALT" },
	keys = keys,
	key_tables = key_tables,
	mouse_bindings = mouse_bindings,
}
