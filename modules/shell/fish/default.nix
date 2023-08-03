{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    loginShellInit = ''
			set -U fish_greeting ""
    '';
  };

  home.file."~/.config/fish/" = {
    source = ./config;
    recursive = true;
  };
}
