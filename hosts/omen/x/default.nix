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
      xkb = {
        layout = "us,fr";
        options = "caps:escape";
      };
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
