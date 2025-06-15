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
    programs.media.mpv
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
      media.mpv.enable = lib.mkDefault true;
    };
  };

  services.playerctld.enable = lib.mkDefault true;

  home.packages = with pkgs; [
    playerctl
    qt6.qtwayland
    wayland-utils
    wev
    wlr-randr
    kdePackages.xwaylandvideobridge
  ];
}
