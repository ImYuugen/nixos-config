{ config, lib, pkgs, user, ... }:

{
  imports = [ (import ../../../modules/desktop/bspwm/home.nix) ] ++
    (import ../../../modules/shell) ++
    (import ../../../modules/editors) ++
#    (import ../../../modules/dev) ++
    (import ../../../modules/programs/xorg);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };
  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
