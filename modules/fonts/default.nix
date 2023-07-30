{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    twemoji-color-font
  ];

  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      ipafont
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      nerdfonts
      source-code-pro
      twemoji-color-font
    ];
    fontconfig = {
      localConf = ''
      '';
      defaultFonts = {
        monospace = [
          "DejaVu Sans Mono"
          "IPAGothic"
        ];
        sansSerif = [
          "DejaVu Sans"
          "IPAPGothic"
        ];
        serif = [
          "DejaVu Serif"
          "IPAPMincho"
        ];
      };
    };
  };
}
