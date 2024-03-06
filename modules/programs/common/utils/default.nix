{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    btop
    eza
    fd
    ripgrep
  ];
  programs.fzf.enable = true;

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
