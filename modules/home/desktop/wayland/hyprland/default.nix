{ config, lib, ... }:

# TODO: Find a way for the user to specify their graphics cards without relying too much on osConfig
# Could pass as an option, but then the user is tied to the system
# Maybe write a script that picks iGPU then dGPU ?

let
  cfg = config.modules.desktop.wayland.hyprland;
in
{
  options.modules.desktop.wayland.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = lib.mkDefault true;
    };

    # Launch Hyprland on login shells
    programs = {
      /*
        bash = lib.mkIf config.modules.programs.shell.bash {
          initExtra = lib.mkDefault ''[ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] && ${config.wayland.windowManager.hyprland.package}'';
        };
        fish = lib.mkIf config.modules.programs.shell.fish {
          loginShellInit = lib.mkDefault ''
            set TTY1 (tty)
            [ "$TTY" = "/dev/tty1" ] && exec ${config.wayland.windowManager.hyprland.package}
          '';
        };
      */
    };

    nix.settings = {
      substituters = lib.mkDefault [ "https://hyprland.cachix.org" ];
      extra-substituters = lib.mkDefault [ "https://hyprland.cachix.org" ];
      extra-trusted-public-keys = lib.mkDefault [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };
}
