{ pkgsSet, ... }: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgsSet.unstable; [
      # Curse of Râ
      aegyptus
      nerdfonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      twemoji-color-font
      symbola
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
