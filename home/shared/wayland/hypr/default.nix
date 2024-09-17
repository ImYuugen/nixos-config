{ inputs
, lib
, pkgsSet
, ...
}:
let
  pkgs = pkgsSet.stable;
in
{
  imports = [
    ./binds.nix
    ./hyprcursor.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./rules.nix
    ./settings.nix
  ];

  nix = {
    settings = {
      extra-substituters = [ "https://hyprland.cachix.org" ];
      extra-trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
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
  ];

  xdg.portal = {
    enable = true;
    configPackages = [
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
    ];
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd = {
      variables = [ "--all" ];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
