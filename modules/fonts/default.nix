{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  ];

  fonts = {
    packages = with pkgs; [
      aegyptus
      nerdfonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      symbola
      twemoji-color-font
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [
          "FiraCode"
          "Noto Sans CJK JP"
        ];
        sansSerif = [
          "DejaVu Sans"
          "Noto Sans CJK JP"
        ];
        serif = [
          "DejaVu Serif"
          "Noto Serif CJK JP"
        ];
      };
    };
  };
}
