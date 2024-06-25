{ pkgsSet, ... }:
let
  pkgs = pkgsSet.stable;
in
{
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [
      rofi-calc
      rofimoji
    ];

    # TODO: Config
  };
}
