{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  ];

  fonts = {
    packages = with pkgs; [
      ipafont
      kochi-substitute
#      (nerdfonts.override {
#        fonts = [
#          "BigBlueTerminal"
#          "FiraCode"
#          "JetBrainsMono"
#          "Iosevka"
#	  "VictorMono"
#        ];
#      })
      nerdfonts
      symbola
      twemoji-color-font
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [
          "FiraCode"
          "IPAPGothic"
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
