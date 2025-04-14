{ ... }:

let
  defConfig = table: ''
    local Config = require("config")

    return Config:init()
        :append(${table})
        :append(require("config.appearance"))
        :append(require("config.bindings"))
        .options
  '';
in
{
  home.sessionVariables.TERMINAL = "wezterm";

  programs.wezterm = {
    enable = true;
  };

  specialisation = {
    light.configuration = {
      programs.wezterm.extraConfig = defConfig "{ color_scheme = \"Catppuccin Latte\" }";
    };
    dark.configuration = {
      programs.wezterm.extraConfig = defConfig "{ color_scheme = \"Catppuccin Macchiato\" }";
    };
  };

  xdg.configFile."wezterm" = {
    source = ./wezterm;
    recursive = true;
  };
}
