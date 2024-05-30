{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    libreoffice-qt
    hunspell
    hunspellDicts.fr-moderne
    hunspellDicts.en_US
  ];
}
