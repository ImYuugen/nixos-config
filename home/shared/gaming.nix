{ pkgsSet, inputs, ... }:
let
  stable = pkgsSet.stable;
  unstable = pkgsSet.unstable;
in
{
  imports = [
    inputs.slippi.homeManagerModule
  ];
  ssbm.slippi-launcher = {
    enable = true;
    # Wah wah user reference - I'm the sole mf using this flake
    isoPath = "/home/yuugen/Games/Super Smash Bros. Melee v1.02 NTSC-U.iso";
  };

  home.packages = with stable; [
    inputs.umu.packages.${system}.umu
    dolphin-emu
    (unstable.lutris.override {
      extraLibraries = pkgs: [ ];
      extraPkgs = pkgs: [ ];
    })
    prismlauncher
    protonplus
    jdk21 # For minecraft
    r2modman
    (retroarch.override { cores = [ ]; })
    winetricks
    wineWowPackages.waylandFull
  ];

  programs.mangohud.enable = true;
}
