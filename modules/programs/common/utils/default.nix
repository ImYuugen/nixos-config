{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    btop
    eza
    fd
    ripgrep
  ];
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  
    fzf = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
