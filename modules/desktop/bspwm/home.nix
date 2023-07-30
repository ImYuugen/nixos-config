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
        "polybar"
        "eww"
      ];
      monitors = {
        DP-2 = [
          "1" "2" "3" "4" "5" "6" "7" "8" "9" "10"
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
      };
      settings = {
        pointer_modifier = "mod4";
        border_width = 1;
        window_gap = 5;
        split_ratio = 0.5;
        borderless_monocle = true;
        gapless_monocle = false;
        focus_follows_pointer = true;

        normal_border_color = "#555555";
        focused_border_color = "#008080";
        urgent_border_color = "#730039";
        # presel_border_color, presel_feedback_color
      };
      extraConfig = let
          LAPTOP_MONITOR="eDP-1-0";
          AOC_EXTERNAL="DP-2";
        in ''
        if [[ "$1" = 0 ]]; then
          if [[ $(xrandr -q | grep "${AOC_EXTERNAL} connected") ]]; then
            bspc monitor "${AOC_EXTERNAL}" -d 1 2 3 4 5 6 7 8 9 10
            bspc wm -O "${AOC_EXTERNAL}"
            xrandr --output ${AOC_EXTERNAL} --mode 1920x1080 --rate 144 --pos 0x0
            xrandr --output ${LAPTOP_MONITOR} --off
          else
            bspc monitor "${LAPTOP_MONITOR}" -d 1 2 3 4 5 6 7 8 9 10
          fi
        fi
      '';
      extraConfigEarly = ''
        systemctl --user start bspwm-session.target
        systemctl --user start tray.target
        bspc monitor -d 1 2 3 4 5 6 7 8 9 10
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
  #programs.fish.loginShellInit = ''
  #  if status --is-login
  #      if test -z "$DISPLAY" -a $XDG_VTNR = 1
  #          exec doas lightdm
  #      end
  #  end
  #'';

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
    if [[ $(xrandr -q | grep "DP-2 connected") ]]; then
      xrandr --output DP-2 --mode 1920x1080 --rate 144 --pos 0x0
    fi
    exec bspwm 
  '';
}
