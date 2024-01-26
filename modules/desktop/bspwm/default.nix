{ config, lib, pkgs, user, ... }:

{
  programs.light.enable = true;

  services.xserver = {
    windowManager.bspwm.enable = true;
    displayManager.defaultSession = "none+bspwm";
  };
}
