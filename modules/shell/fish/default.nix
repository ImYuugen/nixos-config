{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    loginShellInit = ''
    '';
  };
  #home.file.".config/fish/fish_variables".text = import ./fish_variables.nix;
  #home.file.".config/fish/functions".source = ./functions;
}
