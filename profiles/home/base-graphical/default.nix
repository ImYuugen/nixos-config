{
  lib,
  self,
  pkgs,
  ...
}:

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

  home.packages = with pkgs; [
    wayland-utils
    kdePackages.xwaylandvideobridge
    wev
    wlr-randr
    qt6.qtwayland
  ];
}
