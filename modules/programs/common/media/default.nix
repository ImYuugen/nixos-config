{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gvfs
    playerctl
    swappy
  ];

  programs = {
    mpv.enable = true;
  };
}
