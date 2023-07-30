{ config, pkgs, lib, ... }:
{
  home = {
    packages = [ pkgs.eww ];
    file = {
      ".config/eww".source = ./config;
    };
  };
}
