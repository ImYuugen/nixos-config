{ config, inputs, pkgs, user, ... }:

{
  home.packages = with pkgs; [
    wineWowPackages.stagingFull
    winetricks

    heroic

    prismlauncher

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
