{ config, lib, pkgs, user, ... }:
{
  programs = {
    dconf.enable = true;
    light.enable = true;
  };
  services.xserver = {
    windowManager.bspwm.enable = true;
    displayManager.defaultSession = "none+bspwm";
  };
  environment.systemPackages = with pkgs; [
    pamixer
    i3lock-fancy
  ];
}
