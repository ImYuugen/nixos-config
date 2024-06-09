{pkgsSet, ...}: let
  pkgs = pkgsSet.stable;
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      rofi-calc
      rofimoji
    ];

    # TODO: Config
  };
}
