{
  inputs,
  lib,
  self,
  ...
}:

{
  imports = [
    self.homeManagerModules.desktop.wayland.hyprland
  ];
  # TODO

  modules.desktop.wayland.hyprland = {
    enable = true;
  };
}
