{ config, inputs, pkgs, user, ... }:

{
  home.packages = with pkgs; [
    heroic
    mangohud
    prismlauncher
    protonup
    ryujinx
    winetricks
    wineWowPackages.stagingFull
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
