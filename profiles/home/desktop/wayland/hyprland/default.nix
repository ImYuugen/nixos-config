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
    desktop.wayland.grimblast
    desktop.wayland.hyprcursor
    desktop.wayland.hypridle
    desktop.wayland.hyprland
    desktop.wayland.hyprlock
    desktop.wayland.hyprsunset
    desktop.wayland.shikane

    # Defaults I find nice
    ./settings.nix
  ];

  modules.desktop = {
    dunst.enable = true;
    wayland = {
      grimblast.enable = lib.mkDefault true;
      hyprcursor.enable = lib.mkDefault true;
      hypridle.enable = lib.mkDefault true;
      hyprland = {
        enable = lib.mkDefault true;
        autoDetectGPU = lib.mkDefault true;
      };
      hyprlock.enable = lib.mkDefault true;
      hyprsunset.enable = lib.mkDefault true;
      shikane.enable = lib.mkDefault true;
    };
  };

  services.hyprpolkitagent.enable = lib.mkDefault true;
}
