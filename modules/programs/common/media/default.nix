{ config, pkgs, ... }:

{
  packages = with pkgs; [
    playerctl
  ];

  programs = {
    mpv = {
      enable = true;
    };
  };
}
