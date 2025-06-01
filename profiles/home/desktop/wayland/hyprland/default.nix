{
  inputs,
  lib,
  self,
  ...
}:

{
  imports = [
    self.homeManagerModules.desktop.wayland.hyprland

    # Defaults I find nice
    ./settings.nix
  ];

  modules.desktop.wayland.hyprland = {
    enable = true;
  };
}
