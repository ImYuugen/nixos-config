{ pkgsSet, ... }:
let
  stable = pkgsSet.stable;
  unstable = pkgsSet.unstable;
in
{
  home.packages = with stable; [
    unstable.prismlauncher
    jdk21 # For minecraft
    winetricks
    # TODO: mkif wayland config blabla
    wineWowPackages.full
    # wineWowPackages.waylandFull
    (retroarch.override { cores = [ ]; })
    (lutris.override {
      extraLibraries = pkgs: [ ];
      extraPkgs = pkgs: [ ];
    })
  ];

  programs.mangohud.enable = true;
}
