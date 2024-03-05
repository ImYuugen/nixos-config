{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    eza
    bat
    fd
    ripgrep
    tree
    btop
    zoxide
  ];
  programs.fzf.enable = true;
}
