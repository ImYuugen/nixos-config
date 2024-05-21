{ config, pkgs, ... }:

{
  programs = {
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs: [ ];
      };
      gamescopeSession = {
        enable = true;
      };
    };

    gamemode = {
      enable = true;
    };
  };
}
