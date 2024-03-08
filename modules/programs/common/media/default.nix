{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    playerctl
    swappy
  ];

  programs = {
    mpv = {
      enable = true;
    };
  };
}
