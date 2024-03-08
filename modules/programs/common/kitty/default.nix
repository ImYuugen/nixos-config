{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    environment = {
      "TERM" = "kitty";
    };
    theme = "Catppuccin-Mocha";
  };

  xdg.configFile."kitty".source = ./config;
}
