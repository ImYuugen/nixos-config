{ config, lib, pkgs, inputs, ... }:

{
  programs.light.enable = true;

  environment.systemPackages = with pkgs; [
    inputs.hyprcursor
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprlock.packages.${pkgs.system}.hyprlock
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker

    swww
  ];

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
