{
  lib,
  pkgs,
  self,
  ...
}:

{
  key = ./.;

  imports = with self.homeManagerModules; [
    desktop.dunst
    desktop.wayland.hyprcursor
    desktop.wayland.hypridle
    desktop.wayland.hyprland
    desktop.wayland.hyprlock
    desktop.wayland.hyprsunset

    # Defaults I find nice
    ./settings.nix
  ];

  modules.desktop = {
    dunst.enable = true;
    wayland = {
      hyprcursor = {
        enable = lib.mkDefault true;
        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = lib.mkDefault 24;
        };
      };
      hypridle.enable = lib.mkDefault true;
      hyprland = {
        enable = lib.mkDefault true;
        autoDetectGPU = lib.mkDefault true;
      };
      hyprlock.enable = lib.mkDefault true;
      hyprsunset.enable = lib.mkDefault true;
    };
  };
}
