{ pkgsSet, ... }:
let
  EN = "en_US.UTF-8/UTF-8";
  FR = "fr_FR.UTF-8/UTF-8";
  JP = "ja_JP.UTF-8/UTF-8";
  pkgs = pkgsSet.stable;
in
{
  environment.systemPackages = [ pkgs.libsForQt5.fcitx5-configtool ];
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      EN
      FR
      JP
    ];
    # BAZEL IS BROKEN RAAAAH
    # inputMethod = {
    #   enable = true;
    #   type = "fcitx5";
    #   fcitx5 = {
    #     addons = with pkgs; [
    #       fcitx5-gtk
    #       fcitx5-mozc
    #       fcitx5-rose-pine
    #     ];
    #   };
    # };
  };
}
