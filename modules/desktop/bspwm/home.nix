{ config, lib, pkgs, ... }:

{
  imports = [
    (import ../../environment/bspwm-variables.nix)
    (import ../../environment/common-variables.nix)
  ];

  xsession = {
    enable = true;
    windowManager.bspwm = {
      enable = true;
      extraConfig = ''
        sxhkd &
        picom &
        bspc monitor -d 1 2 3 4 5 6 7 8 9 10
      '';
      settings = {
        border_width = 1;
        window_gap = 5;

        focus_follows_pointer = false;
        pointer_follows_focus = false;
        pointer_modifier = "mod4";
        pointer_action1 = "move";
        pointer_action2 = "resize_side";
        pointer_action3 = "resize_corner";

        split_ratio = 0.5;
        borderless_monocle = true;
        gapless_monocle = true;
      };
    };
  };

  systemd.user.targets.bspwm-session = {
    Unit = {
      Description = "bspwm session";
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" "xdg-desktop-autostart.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };

  home.file.".xinitrc".text = ''
    if [ -z $DBUS_SESSION_BUS_ADDRESS ]; then
      eval $(dbus-launch --exit-with-session --sh-syntax)
    fi
    systemctl --user import-environment DISPLAY XAUTHORITY
    if command -v dbus-update-activation-environment >/dev/null 2>&1; then
       dbus-update-activation-environment DISPLAY XAUTHORITY
    fi

    exec bspwm 
  '';
}
