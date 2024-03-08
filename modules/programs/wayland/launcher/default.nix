{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    rofi-wayland
  ];

  home.file.".config/rofi".source = ./config;
}
