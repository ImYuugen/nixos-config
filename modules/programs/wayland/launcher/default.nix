{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    rofi-wayland
  ];

  #home.file.".config/rofi/config".source = ./config;
}
