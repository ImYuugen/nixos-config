{ pkgsSet, ... }:
let
  stable = pkgsSet.stable;
  unstable = pkgsSet.unstable;
  confPkgs = pkgsSet.confPkgs;
in
{
  home.packages = with stable; [
    dolphin-emu
    (unstable.lutris.override {
      extraLibraries = pkgs: [ ];
      extraPkgs = pkgs: [ ];
    })
    prismlauncher
    protonplus
    jdk21 # For minecraft
    r2modman
    (retroarch.override {
      cores = with libretro; [
        citra
        desmume
      ];
    })
    torzu
    pkgsSet.unstable.umu-launcher
    winetricks
    wineWowPackages.waylandFull

    #= Slippi
    confPkgs.slippi-launcher
    #=
  ];

  programs.mangohud.enable = true;
}
