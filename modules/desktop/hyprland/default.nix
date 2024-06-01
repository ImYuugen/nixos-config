{ config, lib, pkgs, inputs, ... }:

{
  programs.light.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = [ "gtk" ];
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
}
