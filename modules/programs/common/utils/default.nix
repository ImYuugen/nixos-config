{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    exa bat fd ripgrep tree htop atop
  ];
  programs.fzf.enable = true;
}
