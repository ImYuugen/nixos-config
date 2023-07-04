{ config, lib, pkgs, ... }:

{
  imports = [ ../../environment/sway-variables.nix ];
  programs = {
    bash.initExtra = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec sway --unsupported-gpu
      fi
    '';
    fish = {
      loginShellInit = ''
        set TTY1 (tty)
        [ "$TTY1" = "/dev/tty1" ] && exec sway --unsupported-gpu
      '';
    };
  };
  systemd.user = {
    targets.sway-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  };
  
  home = {
    packages = with pkgs; [
      swaybg
      swayidle
      swaylock-effects
      pamixer
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    extraOptions = [ "--unsupported-gpu" ];
    wrapperFeatures.gtk = true;
    config = null;

    # Sway config goes there
    extraConfig = ''
      # mod key
        set $mod Mod4

      # Toggle Waybar
        bindsym $mod+Shift+o exec killall -SIGUSR1 .waybar-wrapped

        bindsym $mod+comma workspace prev
        bindsym $mod+period workspace next

      # Monitors
        output eDP-1 resolution 1920x1080@144Hz
        output DP-2 resolution 1920x1080@144Hz position 1920,0
        exec swaymsg focus output DP-2

      # Windows config
        default_border pixel 3
        default_floating_border pixel 3
        gaps inner 5
        gaps outer 0
        
        smart_borders on

      # Always float certain windows
        for_window [app_id="pop-up"]      floating enable
        for_window [app_id="bubble"]      floating enable
        for_window [app_id="task_dialog"] floating enable
        for_window [app_id="Preferences"] floating enable
        for_window [app_id="dialog"]      floating enable
        for_window [app_id="menu"]        floating enable
        for_window [app_id="Organizer"]   floating enable
        for_window [app_id="About"]       floating enable
        for_window [app_id="toolbox"]     floating enable
        for_window [app_id="page-info"]   floating enable
        for_window [app_id="webconsole"]  floating enable
        for_window [app_id="Authy"]       floating enable
        for_window [app_id="termfloat"]   floating enable
        for_window [app_id="termfloat"]   resize set height 540
        for_window [app_id="termfloat"]   resize set width 960
        for_window [app_id="mpv"]         floating enable
        for_window [app_id="mpv"]         resize set height 540
        for_window [app_id="mpv"]         resize set width 960

        
        focus_follows_mouse no

      # Autostart
        exec_always --no-startup-id launch_waybar &
        exec_always --no-startup-id mako &
        exec_always --no-startup-id nm-applet --indicator &

      # Inputs
        input "type:keyboard" {
          xkb_layout us,fr
        }

        input "type:touchpad" {
          tap enabled
          natural_scroll enabled
          accel_profile "flat"
          middle_emulation enabled
        }

      # TODO: Colours

      # Terminal
        set $term alacritty

      # Wallpaper TODO

      # Control Volume
        bindsym XF86AudioRaiseVolume exec pamixer -i 5
        bindsym XF86AudioLowerVolume exec pamixer -d 5
        bindsym XF86AudioMute exec pamixer -t
        bindsym XF86MonBrightnessUp exec light -A 5
        bindsym XF86MonBrightnessDown exec light -U 5
        bindsym XF86AudioPlay exec playerctl play-pause
        bindsym XF86AudioNext exec playerctl next
        bindsym XF86AudioPrev exec playerctl previous

      # Lock Config TODO

      # Key Bindings
        bindsym $mod+Return exec $term
        bindsym $mod+Shift+Return exec $term --class="termfloat"

        bindsym $mod+Shift+s exec --no-startup-id grimshot --notify save area ~/Pictures/$(date "+%Y-%m-%d"T"%H:%M:%S").png
        bindsym $mod+s exec --no-startup-id grimshot --notify copy area

        bindsym $mod+Shift+q kill

        bindsym $mod+d exec pkill rofi || ~/.config/rofi/launcher.sh

        #TODO: Power menu, find a way to detect power button

        bindsym $mod+Shift+c reload

        bindsym $mod+Shift+e exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway ? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'

        floating_modifier $mod normal

      # Moving
        bindsym $mod+Left focus left
        bindsym $mod+Right focus right
        bindsym $mod+Up focus up
        bindsym $mod+Down focus down

        bindsym $mod+Shift+Left move left
        bindsym $mod+Shift+Right move right
        bindsym $mod+Shift+Up move up
        bindsym $mod+Shift+Down move down


      # Workspaces
        bindsym $mod+1 workspace number 1
        bindsym $mod+2 workspace number 2
        bindsym $mod+3 workspace number 3
        bindsym $mod+4 workspace number 4
        bindsym $mod+5 workspace number 5
        bindsym $mod+6 workspace number 6
        bindsym $mod+7 workspace number 7
        bindsym $mod+8 workspace number 8
        bindsym $mod+9 workspace number 9
        bindsym $mod+0 workspace number 10
        # Move focused container to workspace
        bindsym $mod+Shift+1 move container to workspace number 1
        bindsym $mod+Shift+2 move container to workspace number 2
        bindsym $mod+Shift+3 move container to workspace number 3
        bindsym $mod+Shift+4 move container to workspace number 4
        bindsym $mod+Shift+5 move container to workspace number 5
        bindsym $mod+Shift+6 move container to workspace number 6
        bindsym $mod+Shift+7 move container to workspace number 7
        bindsym $mod+Shift+8 move container to workspace number 8
        bindsym $mod+Shift+9 move container to workspace number 9
        bindsym $mod+Shift+0 move container to workspace number 10
        # move focused container to workspace(follow)
        bindsym $mod+Ctrl+1 move container to workspace number 1,  workspace 1
        bindsym $mod+Ctrl+2 move container to workspace number 2,  workspace 2
        bindsym $mod+Ctrl+3 move container to workspace number 3,  workspace 3
        bindsym $mod+Ctrl+4 move container to workspace number 4,  workspace 4
        bindsym $mod+Ctrl+5 move container to workspace number 5,  workspace 5
        bindsym $mod+Ctrl+6 move container to workspace number 6,  workspace 6
        bindsym $mod+Ctrl+7 move container to workspace number 7,  workspace 7
        bindsym $mod+Ctrl+8 move container to workspace number 8,  workspace 8
        bindsym $mod+Ctrl+9 move container to workspace number 9,  workspace 9
        bindsym $mod+Ctrl+0 move container to workspace number 10, workspace 10

      # Layout
        bindsym $mod+semicolon splitv
        bindsym $mod+apostrophe splith

        bindsym $mod+w layout tabbed
        bindsym $mod+e layout stacking
        bindsym $mod+q toggle split
        bindsym $mod+f fullscreen

        bindsym $mod+Shift+space floating toggle
        bindsym $mod+space focus mode_toggle

        bindsym $mod+p focus parent
        bindsym $mod+o focus child

      # Resizing
        bindsym $mod+r mode "resize"
        mode "resize" {
          bindsym Left resize shrink width 10px
          bindsym Right resize grow width 10px
          bindsym Up resize grow height 10px
          bindsym Down resize shrink height 10px

          bindsym Return mode "default"
          bindsym Escape mode "default"
        }

      bindsym Shift+Ctrl+Left          resize shrink width  5 px or 5 ppt
      bindsym Shift+Ctrl+Up            resize grow   height 5 px or 5 ppt
      bindsym Shift+Ctrl+Down          resize shrink height 5 px or 5 ppt
      bindsym Shift+Ctrl+Right         resize grow   width  5 px or 5 ppt
    '';
  };
}
