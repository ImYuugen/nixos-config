{ config, pkgs, lib, user, ... }:
{
  home = {
    packages = [ pkgs.polybarFull ];

    file.".config/polybar".text = ''
      wm-restack = bspwm

      [bar/topbar]
      height = 5
      modules-left =
      modules-right =
    '';
  };
}
