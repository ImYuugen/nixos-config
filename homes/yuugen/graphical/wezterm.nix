{ self, ... }:

{
  imports = [
    self.homeManagerModules.programs.terminals.wezterm
  ];

  modules.programs.terminals.wezterm.enable = true;

  # When using stylix, this will be properly integrated, xdg.configFile won't
  programs.wezterm.extraConfig = ''
    return {
      -- Appearance
      max_fps = 60,
      animation_fps = 60,
      cursor_blink_ease_in = "EaseOut",
      cursor_blink_ease_out = "EaseOut",
      default_cursor_style = "BlinkingBlock",
      cursor_blink_rate = 650,
      enable_tab_bar = true,
      hide_tab_bar_if_only_one_tab = true,
      use_fancy_tab_bar = true,
      visual_bell = {
        fade_in_function = "EaseIn",
        fade_in_duration_ms = 250,
        fade_out_function = "EaseOut",
        fade_out_duration_ms = 250,
        target = "CursorColor",
      },
      window_close_confirmation = "NeverPrompt",
      -- Necessary for Darkman
      automatically_reload_config = true,

      -- Keybinds
      disable_default_key_bindings = true,
      leader = { key = "Space", mods = "CTRL|ALT" },
      keys = {
        { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
        { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
        -- Tabs
      	{
      		key = "t",
      		mods = "CTRL|SHIFT",
      		action = wezterm.action.SpawnTab("DefaultDomain"),
      	},
      	{
      		key = "w",
      		mods = "CTRL|SHIFT",
      		action = wezterm.action.CloseCurrentTab({ confirm = false }),
      	},
      	{
      		key = "Tab",
      		mods = "CTRL",
      		action = wezterm.action.ActivateTabRelative(1),
      	},
      	{
      		key = "Tab",
      		mods = "CTRL|SHIFT",
      		action = wezterm.action.ActivateTabRelative(-1),
      	},

      	-- Panes
      	{
      		key = [[\]],
      		mods = "CTRL|ALT",
      		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
      	},
      	{
      		key = "|",
      		mods = "CTRL|ALT|SHIFT",
      		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
      	},
      	{
      		-- Space because it's the fastest
      		key = "Space",
      		mods = "LEADER",
      		action = wezterm.action.ActivateKeyTable({
      			name = "pane_control",
      			one_shot = false,
      			timemout_miliseconds = 1000,
      		}),
      	},
      },
      key_tables = {
        pane_control = {
          -- Navigate
        	{ key = "k", action = wezterm.action.ActivatePaneDirection("Up") },
        	{ key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
        	{ key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
        	{ key = "l", action = wezterm.action.ActivatePaneDirection("Right") },
          -- Resize
      		{ key = "k", mods = "CTRL", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
      		{ key = "j", mods = "CTRL", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
      		{ key = "h", mods = "CTRL", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
      		{ key = "l", mods = "CTRL", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },

      		{ key = "Escape", action = "PopKeyTable" },
        },
      },
      mouse_bindings = {
        {
          event = { Up = { streak = 1, button = "Left" } },
          mods = "CTRL",
          action = wezterm.action.OpenLinkAtMouseCursor,
        },
      },
    }
  '';
}
