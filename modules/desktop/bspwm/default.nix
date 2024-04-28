{ config, lib, pkgs, user, ... }:

{
  programs.light.enable = true;

  services.xserver = {
    displayManager.defaultSession = "none+bspwm";
  };
}
