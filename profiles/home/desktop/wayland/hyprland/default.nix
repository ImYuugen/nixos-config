{
  inputs,
  lib,
  self,
  ...
}:

{
  key = ./.;

  imports = [
    self.homeManagerModules.desktop.dunst
    self.homeManagerModules.desktop.wayland.hyprland

    # Defaults I find nice
    ./settings.nix
  ];

  modules.desktop = {
    dunst.enable = true;
    wayland.hyprland = {
      enable = lib.mkDefault true;
      autoDetectGPU = lib.mkDefault true;
    };
  };
}
