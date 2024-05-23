{ config, pkgs, ... }:

{
  programs = {
    steam = {
      enable = true;
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
      gamescopeSession = {
        enable = true;
      };
    };

    gamemode = {
      enable = true;
    };
  };
}
