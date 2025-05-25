{ inputs, pkgsSet, ... }:
let
  pkgs = pkgsSet.stable;
in
{
  imports = [
    ./binds.nix
    ./hyprcursor.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprsunset.nix
    ./rules.nix
    ./settings.nix
  ];

  nix = {
    settings = {
      extra-substituters = [ "https://hyprland.cachix.org" ];
      extra-trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  programs = {
    bash.initExtra = ''
      [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] && exec Hyprland
    '';
    fish.loginShellInit = ''
      set TTY1 (tty)
      [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
    '';
  };

  gtk.enable = true;
  qt = {
    enable = true;
    style = {
      package = pkgs.catppuccin-qt5ct;
    };
  };
  specialisation = {
    light.configuration = {
      gtk.theme = {
        package = (
          pkgsSet.unstable.magnetic-catppuccin-gtk.override {
            accent = [ "teal" ];
            shade = "light";
          }
        );
        name = "Catppuccin-GTK-Teal-Light";
      };
      qt.style.name = "catppuccin-latte-teal";
    };
    dark.configuration = {
      gtk.theme = {
        package = (
          pkgsSet.unstable.magnetic-catppuccin-gtk.override {
            accent = [ "teal" ];
            shade = "dark";
            tweaks = [ "macchiato" ];
          }
        );
        name = "Catppuccin-GTK-Teal-Dark-Macchiato";
      };
      qt.style.name = "catppuccin-macchiato-teal";
    };
  };

  home.packages = [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
  ];

  services.hyprpolkitagent.enable = true;

  xdg.portal = {
    enable = true;
    configPackages = with pkgs; [ xdg-desktop-portal-hyprland ];
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      variables = [ "--all" ];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
