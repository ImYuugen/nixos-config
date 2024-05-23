{ config, inputs, pkgs, user, wayland, ... }:

{
  home.packages = with pkgs; [
    heroic
    mangohud
    prismlauncher
    ryujinx
    steamcmd
    steam-tui
    winetricks
    (if wayland then
      wineWowPackages.waylandFull
    else
      wineWowPackages.stagingFull
    )
    (retroarchFull.override {
      cores = with libretro; [
        citra
        dolphin
      ];
    })
    (lutris.override {
      extraLibraries = pkgs: [
        pkgs.libunwind
      ];
      extraPkgs = pkgs: [
      ];
    })
  ];
}
