{
  config,
  lib,
  pkgs,
  ...
}:

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
      xwayland.enable = lib.mkDefault true;
      systemd = {
        variables = lib.mkDefault [ "--all" ];
        extraCommands = lib.mkDefault [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };
    };

    xdg.portal = {
      enable = lib.mkDefault true;
      configPackages = lib.mkDefault [ pkgs.xdg-desktop-portal-hyprland ];
      extraPortals = lib.mkDefault [ pkgs.xdg-desktop-portal-gtk ];
    };

    # Launch Hyprland on login shells
    programs =
      let
        hyprBin = "${config.wayland.windowManager.hyprland.package}/bin/Hyprland";
      in
      {
        bash = lib.mkIf config.modules.programs.shells.bash.enable {
          initExtra = ''[ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] && ${hyprBin}'';
        };
        fish = lib.mkIf config.modules.programs.shells.fish.enable {
          loginShellInit = ''
            set TTY1 (tty)
            [ "$TTY" = "/dev/tty1" ] && exec ${hyprBin}
          '';
        };
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
