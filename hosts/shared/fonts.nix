{ pkgsSet, ... }:
let
  nf = with pkgsSet.unstable.nerd-fonts; [
    _0xproto
    departure-mono
    fira-code
    iosevka
    jetbrains-mono
    noto
    roboto-mono
    symbols-only
  ];
in
{
  fonts = {
    enableDefaultPackages = true;
    packages =
      with pkgsSet.unstable;
      [
        # Curse of Râ
        material-design-icons
        material-symbols
        noto-fonts-cjk-serif
        noto-fonts-cjk-sans
        twemoji-color-font
      ]
      ++ nf;
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
