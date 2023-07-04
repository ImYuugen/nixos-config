{ config, lib, pkgs, ... }:
{
  imports = [
    ../../programs/wayland/waybar
  ];
  programs = {
    dconf.enable = true;
    light.enable = true;
  };

  security.pam.services.swaylock = {};

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };
}
