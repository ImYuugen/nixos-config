{ pkgs, pkgsSet, ... }:

let
  variant = "mocha";
  accent = "green";
  flavor = "catppuccin-${variant}-${accent}";
in
{
  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk = {
    enable = true;
    theme = {
      name = "${flavor}-standard";
      package = pkgs.catppuccin-gtk.override {
        inherit variant;
        accents = [ accent ];
      };
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  systemd.user.sessionVariables = {
    QT_STYLE_OVERRIDE = "kvantum";
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=${flavor}
    '';
    "Kvantum/${flavor}".source = "${
      pkgs.catppuccin-kvantum.override {
        inherit variant accent;
      }
    }/share/Kvantum/${flavor}";

    "qt5ct/qt5ct.conf".text = ''
      [Appearance]
      icon_theme = "Papirus-Dark";
    '';
    "qt6ct/qt6ct.conf".text = ''
      [Appearance]
      icon_theme = "Papirus-Dark";
    '';
  };

  home = {
    packages = with pkgs; [
      (catppuccin-kvantum.override {
        inherit accent variant;
      })
      libsForQt5.qt5ct
      papirus-icon-theme
      pkgsSet.unstable.quickshell
    ];
  };
}
