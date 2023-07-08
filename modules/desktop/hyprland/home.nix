{ config, lib, pkgs, ... }:
{
  imports = [
    (import ../../environment/hypr-variables.nix)
  ];
  programs = {
    bash = {
      initExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
          exec Hyprland
        fi
      '';
    };
    fish = {
      #loginShellInit = ''
      #  set TTY1 (tty)
      #  [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
      #'';
    };
  };

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    nvidiaPatches = true;
    xwayland = {
      enable = true;
      hidpi = true;
    };
    extraConfig = ''
      $mainMod = MOD4
      $appMod = ALT SHIFT

      monitor = eDP-1,1920x1080@144Hz,0x0,1
      monitor = DP-2,1920x1080@144Hz,1920x0,1

      ### ENV VARS ###
      env = LIBVA_DRIVER_NAME, nvidia
      env = GBM_BACKEND, nvidia-drm
      __GLX_VENDOR_LIBRARY_NAME, nvidia

      input {
        kb_layout = us,fr
        numlock_by_default = true
        repeat_rate = 30

        follow_mouse = 1
        sensitivity = -0.1
        accel_profile = "flat"

        touchpad {
          natural_scroll = true
          middle_button_emulation = true
          clickfinger_behavior = true # 1fg = LMB, 2fg = RMB, 3fg = MMB
          disable_while_typing = false # Like bruh why is it even true by default
        }
      }

      general {
        border_size = 1
        gaps_in = 3
        gaps_out = 3
        
        cursor_inactive_timeout = 10

        layout = dwindle
      }

      dwindle {
      }

      master {
      }

      decoration {
        drop_shadow = false
        shadow_range = 4
        shadow_offset = [5, 3]
      }

      animations {
        enabled = true
      }

      gestures {
        workspace_swipe = true
        workspace_swipe_fingers = 4
      }

      misc {
      }

      bind = $mainMod, Return, exec, alacritty
      bind = $mainMod SHIFT, Q, killactive,
      bind = $mainMod SHIFT, P, exec, ~/.config/rofi/bin/powermenu.sh
      bind = $mainMod SHIFT, L, exec, swaylock --screenshots --clock --indicator --effect-blur 7x5
      bind = $mainMod, E, exec, alacritty -e joshuto
      bind = $mainMod, D, exec, rofi -show drun
      bind = $appMod, B, exec, nvidia-offload firefox


      bind = $mainMod, Space, togglefloating,
      bind = $mainMod, F, fullscreen,
      bind = $mainMod, P, pseudo,
      bind = $mainMod, J, togglesplit

      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
      #TODO: left right workspace with [, ]

      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 0
      #TODO: left right workspace with [, ]

      bind = $mainMod SHIFT, Left, movewindow, l
      bind = $mainMod SHIFT, Right, movewindow, r
      bind = $mainMod SHIFT, Up, movewindow, u
      bind = $mainMod SHIFT, Down, movewindow, d

      # Volume, Brightness, Media
      bind = , XF86MonBrightnessDown, exec, light -U 5
      bind = , XF86MonBrightnessUp, exec, light -A 5
      bind = , XF86AudioMute, exec, pamixer -t 
      bind = , XF86AudioLowerVolume, exec, pamixer -d 5
      bind = , XF86AudioRaiseVolume, exec, pamixer -i 5
      bind = , XF86AudioPrev, exec, playerctl previous
      bind = , XF86AudioPlay, exec, playerctl play-pause
      bind = , XF86AudioNext, exec, playerctl next


      ### RESIZE/MOVE MODE ###
      bind = $mainMod, r, submap, resize
      submap = resize
      binde = , Left, resizeactive, -40 0
      binde = , Right, resizeactive, 40 0
      binde = , Up, resizeactive, 0 -40
      binde = , Down, resizeactive, 0 40
      binde = SHIFT, Left, moveactive, -40 0
      binde = SHIFT, Right, moveactive, 40 0
      binde = SHIFT, Up, moveactive, 0 -40
      binde = SHIFT, Down, moveactive, 0 40
      bind = , escape, submap, reset
      submap = reset
      ### END ###

      # Autostart
      exec-once = mako &
      exec-once = waybar &
      exec-once = playerctld daemon &
    '';
  };
}
