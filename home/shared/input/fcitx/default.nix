{ config, pkgsSet, ... }:

let
  pkgs = pkgsSet.stable;
in
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        catppuccin-fcitx5
      ];
    };
  };

  xdg.configFile."fcitx5" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config/fcitx5;
    recursive = true;
  };
}
