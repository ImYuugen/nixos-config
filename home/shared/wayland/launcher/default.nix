{ pkgsSet, ... }:
let
  pkgs = pkgsSet.stable;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [ ];
  };

  xdg.configFile."rofi" = {
    source = ./config;
    recursive = true;
  };
}
