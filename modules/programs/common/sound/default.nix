{ config, pkgs, ... }:

{
  services.easyeffects = {
    enable = true;
    preset = "Loud + Bass";
  };
}
