{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    btop
    eza
    fd
    ripgrep
    zoxide
  ];
  programs.fzf.enable = true;
}
