{ config, pkgs, ... }:

{
  programs = {
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs: [ ];
      };
    };

    gamemode = {
      enable = true;
    };
  };
}
