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

  file.".config/bspwm" = {
    source = ./bspwm;
    recursive = true;
  };

  file.".xinitrc".text = ''
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
