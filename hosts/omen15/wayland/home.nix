{ config, lib, pkgs, user, ... }:

{
  imports = [(import ../../../modules/desktop/hyprland/home.nix)]
  ++ (import ../../../modules/shell)
  ++ (import ../../../modules/editors)
  ++ (import ../../../modules/programs/wayland);
  # TODO: Put a theme

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };
  programs.home-manager.enable = true;

  #home.stateVersion = "23.11";
  home.stateVersion = "23.05";
}
