{ config, user, pkgs, ... }:

{
  programs.ags = {
    enable = true;
    configDir = ./config;
    extraPackages = with pkgs; [ ];
  };
}
