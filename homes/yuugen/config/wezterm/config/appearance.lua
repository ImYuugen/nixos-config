local wezterm = require("wezterm")

return {
  max_fps = 60,
  animation_fps = 60,
  cursor_blink_ease_in = "EaseOut",
  cursor_blink_ease_out = "EaseOut",
  default_cursor_style = "BlinkingBlock",
  cursor_blink_rate = 650,

  font = wezterm.font_with_fallback({
    "Moralerspace Argon NF",
    "Noto Sans NF",
  }),

  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = true,

  inactive_pane_hsb = {
    saturation = 1,
    brightness = 0.9,
  },

  visual_bell = {
    fade_in_function = "EaseIn",
    fade_in_duration_ms = 250,
    fade_out_function = "EaseOut",
    fade_out_duration_ms = 250,
    target = "CursorColor",
  },

  window_close_confirmation = "NeverPrompt",
}
