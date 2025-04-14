{ pkgsSet, ... }:

let
  pkgs = pkgsSet.stable;
in
{
  home.packages = [ pkgs.libsForQt5.fcitx5-configtool ];

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        catppuccin-fcitx5
      ];
    };
  };
}
