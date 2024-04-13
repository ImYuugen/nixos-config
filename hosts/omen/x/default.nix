{ config, inputs, lib, pkgs, user, ... }:

{
  imports = [
    ../../../modules/desktop/bspwm
  ];

  environment.systemPackages = with pkgs; [
    arandr
    xorg.xev
    xorg.xinit
    xorg.xrandr
  ];

  services = {
    xserver = {
      enable = true;
      layout = "us,fr";
      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = true;
        };
        mouse = {
          accelProfile = "flat";
        };
      };
    };
  };
}
