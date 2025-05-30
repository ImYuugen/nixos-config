{ self, ... }:

{
  imports = [
    self.profiles.desktop.wayland.hyprland
  ];
}
