{ config, lib, pkgs, ... }:

{
  imports = [
    (import ../../environment/hypr-variables.nix)
    (import ../../environment/common-variables.nix)
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

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark";
    size = 22;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Dark";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
      };
    };
  };

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  home.file.".config/hypr" = {
    source = ./config;
    recursive = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    systemdIntegration = true;
    xwayland.enable = true;

#    settings = {
#      input = {
#        kb_layout = "us,fr";
#        kb_options = "grp:win_space_toggle,caps:escape";
#      };
#    };
  };
}
