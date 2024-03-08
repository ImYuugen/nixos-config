{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    playerctl
  ];

  programs = {
    mpv = {
      enable = true;
    };
  };
}
