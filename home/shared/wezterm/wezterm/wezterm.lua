local wezterm = require 'wezterm'
local config = wezterm.config_builder()
-- TODO: the whole config
config.color_scheme = 'rose-pine'
config.enable_wayland = false
return config
