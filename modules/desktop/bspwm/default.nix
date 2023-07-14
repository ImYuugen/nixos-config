{ config, lib, pkgs, user, ... }:
{
  imports = [ ../../xorg/polybar ];
  services.xserver = {
    enable = true;
    displayManager.lightdm = {
      enable = true;
    };
  };

  programs = {
    dconf.enable = true;
    light.enable = true;
  };
  environment.systemPackages = with pkgs; [
    pamixer
    i3lock-fancy
  ];
}
