{ lib, self, ... }:
{
  key = ./.;

  imports = with self.homeManagerModules; [
    profiles.desktop.wayland.hyprland
    profiles.programs.browsers.firefox

    desktop.rofi
  ];

  modules = {
    desktop = {
      rofi.enable = lib.mkDefault true;
    };
    programs = {
      browsers.firefox.enable = lib.mkDefault true;
    };
  };
}
