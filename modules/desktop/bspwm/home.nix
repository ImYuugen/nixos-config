{ config, lib, pkgs, ... }:

{
  imports = [
    (import ../../environment/bspwm-variables.nix)
  ];

  xsession = {
    enable = true;
    numlock.enable = true;
    windowManager.bspwm = {
      enable = true;
      alwaysResetDesktops = true;
      startupPrograms = [
        "sxhkd"
        "flameshot"
        "dunst"
        "sleep 2s; polybar -q main"
      ];
      monitors = {
        eDP-2 = [
          "I" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" "X"
        ];
      };
      rules = {
        "mpv" = {
          state = "floating";
          center = true;
        };
        "termfloat" = {
          state = "floating";
          center = true;
        };
        "nemo" = {
          state = "floating";
          center = true;
        };
      };
      settings = {
        pointer_modifier = "mod4";
        border_width = 3;
        window_gap = 5;
        split_ratio = 0.5;
        borderless_monocle = true;
        gapless_monocle = false;
        focus_follows_pointer = true;

        normal_border_color = "#008080";
        # focused_border_color, urgent_border_color, presel_border_color, presel_feedback_color
      };
      extraConfig = ''
      '';
      extraConfigEarly = ''
        systemctl --user start bspwm-session.target
        systemctl --user start tray.target
      '';
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
  programs.fish.loginShellInit = ''
    if status --is-login
        if test -z "$DISPLAY" -a $XDG_VTNR = 1
            exec lightdm
        end
    end
  '';

  home.file.".xinitrc".text = ''
    if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval $(dbus-launch --exit-with-session --sh-syntax)
    fi
    systemctl --user import-environment DISPLAY XAUTHORITY
    if command -v dbus-update-activation-environment >/dev/null 2>&1; then
       dbus-update-activation-environment DISPLAY XAUTHORITY
    fi
    ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
      Xcursor.theme: Catppuccin-Frappe-Dark
      ''}
    exec bspwm 
  '';
}
