{ pkgsSet, inputs, ... }:
let
  stable = pkgsSet.stable;
  unstable = pkgsSet.unstable;
in
{
  home.packages = with stable; [
    # inputs.umu.packages.${system}.umu
    (unstable.lutris.override {
      extraLibraries = pkgs: [ ];
      extraPkgs = pkgs: [ ];
    })
    prismlauncher
    protonplus
    jdk21 # For minecraft
    (retroarch.override { cores = [ ]; })
    winetricks
    wineWowPackages.waylandFull
  ];

  programs.mangohud.enable = true;
}
