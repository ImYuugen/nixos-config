{ pkgsSet, ... }: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgsSet.unstable; [
      # Curse of Râ
      material-design-icons
      nerdfonts
      noto-fonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      twemoji-color-font
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [
          "IosevkaTermNFM"
          "Noto Sans CJK JP"
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Sans CJK JP"
        ];
        serif = [
          "Noto Serif"
          "Noto Serif CJK JP"
        ];
      };
    };
  };
}
