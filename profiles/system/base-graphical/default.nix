{
  lib,
  pkgs,
  self,
  ...
}:

{
  key = ./.;

  environment.systemPackages = with pkgs; [
    brightnessctl
    libnotify
    libva
    libva-utils
  ];

  xdg.portal = {
    enable = lib.mkDefault true;
    wlr.enable = lib.mkDefault true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
}
