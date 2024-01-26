{ config, inputs, pkgs, user, ... }:

{
  #programs.steam = {
  #  enable = true;
  #};
  #programs.gamemode.enable = true;

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
