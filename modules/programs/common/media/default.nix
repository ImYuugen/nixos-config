{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gvfs
    playerctl
    swappy
    vlc
  ];

  programs = {
    mpv.enable = true;
  };
}
