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

  gtk = {
    enable = true;
  };

  home.packages = [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    inputs.hyprpolkitagent.packages.${pkgs.system}.hyprpolkitagent
    inputs.hyprsunset.packages.${pkgs.system}.hyprsunset
  ];

  xdg.portal = {
    enable = true;
    configPackages = [ pkgsSet.stable.xdg-desktop-portal-hyprland ];
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
