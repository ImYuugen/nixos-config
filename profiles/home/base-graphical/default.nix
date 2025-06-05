{ lib, self, ... }:

{
  key = ./.;

  imports = with self.homeManagerModules; [
    profiles.desktop.wayland.hyprland

    desktop.rofi
    programs.browsers.firefox
  ];

  modules = {
    desktop = {
      rofi.enable = lib.mkDefault true;
    };
    programs = {
      browsers.firefox = {
        enable = lib.mkDefault true;
        defaultBrowser = lib.mkDefault true;
      };
    };
  };
}
