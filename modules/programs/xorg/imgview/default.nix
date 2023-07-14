{ config, pkgs, ... }:
{
  home = {
    packages = [
      pkgs.feh
    ];
  };
}
