{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    eza
    bat
    fd
    ripgrep
    tree
    btop
  ];
  programs.fzf.enable = true;
}
