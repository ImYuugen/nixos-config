{ config, pkgs, ... }:

{
  programs = {
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession = {
        enable = true;
      };
    };

    gamemode = {
      enable = true;
    };
  };
}
