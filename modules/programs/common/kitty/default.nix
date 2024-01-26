{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    environment = {
      "TERM" = "kitty";
    };
    theme = "Catppuccin-Mocha";
    extraConfig = ''
      font_family VictorMono NFM
      bold_font VictorMono NFM Bold
      italic_font VictorMono NFM Italic
      bold_italic_font VictorMono NFM Bold Italic

      font_size 14.0

      symbol_map U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0C8,U+E0CA,U+E0CC-U+E0D2,U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E634,U+E700-U+E7C5,U+EA60-U+EBEB,U+F000-U+F2E0,U+F300-U+F32F,U+F400-U+F4A9,U+F500-U+F8FF Symbols Nerd Font

      scrollback_lines 10000
      enable_audio_bell no
      hide_window_decorations yes
    '';
  };
}
