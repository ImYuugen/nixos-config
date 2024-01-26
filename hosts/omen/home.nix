{ config, lib, pkgs, user, ... }:

{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
