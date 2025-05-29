{ pkgsSet, ... }:

let
  nerdfonts = with pkgsSet.unstable.nerd-fonts; [
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
        material-design-icons
        material-symbols
        ipafont
        twemoji-color-font
      ]
      ++ nerdfonts;
  };
}
