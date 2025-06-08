{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.desktop.wayland.hyprland;
in
{
  options.modules.desktop.wayland.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
    # Use this to run ./create_aq_drm.sh on each boot
    autoDetectGPU = lib.mkEnableOption "Auto-detect GPU";
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
        detectAqDRM = pkgs.writeShellApplication {
          name = "detectAqDRM";
          runtimeInputs = [ pkgs.pciutils ];
          text = builtins.readFile ./create_aq_drm.sh;
        };
      in
      {
        bash = lib.mkIf config.home.shell.enableBashIntegration {
          initExtra = ''
            [ -z $DISPLAY ] && \
              [ "$(tty)" = "/dev/tty1" ] && \
              ${(lib.strings.optionalString cfg.autoDetectGPU "export AQ_DRM_DEVICES=$(${lib.getExe detectAqDRM})")} && \
              ${hyprBin}
          '';
        };
        fish = lib.mkIf config.home.shell.enableFishIntegration {
          loginShellInit = ''
            set TTY1 (tty)
            [ "$TTY1" = "/dev/tty1" ] && \
              ${(lib.strings.optionalString cfg.autoDetectGPU "set -x AQ_DRM_DEVICES $(${lib.getExe detectAqDRM})")} && \
              exec ${hyprBin}
          '';
        };
        zsh = lib.mkIf config.home.shell.enableZshIntegration {
          loginExtra = ''
            [ -z $DISPLAY ] && \
              [ "$(tty)" = "/dev/tty1" ] && \
              ${(lib.strings.optionalString cfg.autoDetectGPU "export AQ_DRM_DEVICES=$(${lib.getExe detectAqDRM})")} && \
              ${hyprBin}
          '';
        };
      };

    nix.settings = {
      extra-substituters = lib.mkDefault [ "https://hyprland.cachix.org" ];
      extra-trusted-public-keys = lib.mkDefault [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };
}
