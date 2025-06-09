{
  lib,
  self,
  ...
}:

{
  key = ./.;

  imports = [
    self.homeManagerModules.desktop.dunst
    self.homeManagerModules.desktop.wayland.hypridle
    self.homeManagerModules.desktop.wayland.hyprland
    self.homeManagerModules.desktop.wayland.hyprlock
    self.homeManagerModules.desktop.wayland.hyprsunset

    # Defaults I find nice
    ./settings.nix
  ];

  modules.desktop = {
    dunst.enable = true;
    wayland = {
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
