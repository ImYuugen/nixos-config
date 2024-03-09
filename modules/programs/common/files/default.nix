{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    libsForQt5.dolphin
    libsForQt5.dolphin-plugins
  ];
}
