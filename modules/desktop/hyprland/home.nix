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

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  wayland.windowManager.hyprland = {
    enable = true;
    #nvidiaPatches = true;
    systemdIntegration = true;
    xwayland.enable = true;
  };

  home.file.".config/hypr" = {
    source = ./config;
    recursive = true;
  };
}
