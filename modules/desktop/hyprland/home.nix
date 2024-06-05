{ config, inputs, lib, pkgs, unstable, ... }:

{
  imports = [
    ../../environment/common-variables.nix
    ./binds.nix
    ./settings.nix
    ./rules.nix
  ];

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
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-dark-gtk;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 20;
  };

  home.packages = [
    inputs.hyprcursor
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprlock.packages.${pkgs.system}.hyprlock
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    pkgs.swww
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    plugins = [ ];
    systemd = {
      enable = true;
      variables = [ "--all" ];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
