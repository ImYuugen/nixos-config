{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    twemoji-color-font
  ];

  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      nerdfonts
      twemoji-color-font
    ];
    fontconfig = {
      localConf = ''
      '';
    };
  };
}
