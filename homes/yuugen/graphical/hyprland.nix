{
  config,
  lib,
  self,
  ...
}:

let
  workspaceBinds = builtins.concatLists (
    builtins.genList (
      x:
      let
        ws =
          let
            c = (x + 1) / 10;
          in
          builtins.toString (x + 1 - (c * 10));
        actual = builtins.toString (x + 1);
      in
      [
        "$mainMod, ${ws}, Focuses workspace ${actual}, workspace, ${actual}"
        "$mainMod CTRL, ${ws}, Moves the current window to workspace ${actual}, movetoworkspace, ${actual}"
        "$mainMod SHIFT, ${ws}, Follows the current window to workspace ${actual}, movetoworkspacesilent, ${actual}"
      ]
    ) 10
  );
in
{
  imports = [
    self.homeManagerModules.desktop.wayland.hyprpaper
  ];
  modules.desktop.wayland.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preload = [ "${self.outPath}/assets/images/ceci.jpg" ];
    wallpaper = [ ",${self.outPath}/assets/images/ceci.jpg" ];
  };

  wayland.windowManager.hyprland = {
    settings = {
      "$mainMod" = "SUPER";
      "$appMod" = "ALT SHIFT";

      "$terminal" = "wezterm";

      animations = {
        enabled = true;
      };

      animation = [
        "windows, 1, 7, default, slide"
        "windowsOut, 0"
        "fadeIn, 0"
        "fadeOut, 0"
        "workspaces, 1, 5, default"
      ];

      binds = {
        workspace_back_and_forth = true;
      };

      bindd =
        [
          "$mainMod SHIFT, Q, Closes the current window, killactive,"
          "$mainMod, Return, Opens your preferred terminal emulator, exec, $terminal"
          "$mainMod, D, Opens your preferred app launcher, exec, rofi -show drun"
          "$mainMod SHIFT, D, Opens your preferred cmd launcher, exec, rofi -show run"
          "$appMod, W, Opens your preferred web browser, exec, $BROWSER"
          # Lock
          "$mainMod SHIFT, X, Locks the session, exec, hyprlock"
          ", XF86Launch2, Locks the session, exec, hyprlock"
          # Screenshots
          "$mainMod, Print, Takes a screenshot and places it in the clipboard, exec, grimblast --notify copy screen"
          "$mainMod SHIFT, S, Select an area to paste to the clipboard, exec, grimblast --notify copy area"
          "$mainMod SHIFT, Print, Select and area and save it in a file, exec, grimblast --notify --freeze save area"
          # Layout
          "$mainMod, F, Switches current window between floating and tiling mode, togglefloating,"
          "$mainMod, M, Toggles fullscreen for current window, fullscreen,"
          "$mainMod, P, Toggles pseudotile mode, pseudo"
          "$mainMod, apostrophe, Toggles between horizontal and vertical split, togglesplit,"
          "$mainMod, Y, Pins the current window, pin"
          # Windows
          "$mainMod, left, Focuses the window to the west, movefocus, l"
          "$mainMod, H, Focuses the window to the west, movefocus, l"
          "$mainMod, down, Focuses the window to the south, movefocus, d"
          "$mainMod, J, Focuses the window to the south, movefocus, d"
          "$mainMod, up, Focuses the window to the north, movefocus, u"
          "$mainMod, K, Focuses the window to the north, movefocus, u"
          "$mainMod, right, Focuses the window to the east, movefocus, r"
          "$mainMod, L, Focuses the window to the east, movefocus, r"
          # Move windows
          "$mainMod SHIFT, left, Moves the current window to the west, movewindow, l"
          "$mainMod SHIFT, H, Moves the current window to the west, movewindow, l"
          "$mainMod SHIFT, down, Moves the current window to the south, movewindow, d"
          "$mainMod SHIFT, J, Moves the current window to the south, movewindow, d"
          "$mainMod SHIFT, up, Moves the current window to the north, movewindow, u"
          "$mainMod SHIFT, K, Moves the current window to the north, movewindow, u"
          "$mainMod SHIFT, right, Moves the current window to the east, movewindow, r"
          "$mainMod SHIFT, L, Moves the current window to the east, movewindow, r"
          # Media controls
          ", XF86AudioPrev, Previous track, exec, playerctl previous"
          ", XF86AudioPlay, Play/Pause track, exec, playerctl play-pause"
          ", XF86AudioNext, Next track, exec, playerctl next"
        ]
        ++ [
          # Workspace navigation
          "$mainMod, Period, Go up a workspace, workspace, e+1"
          "$mainMod, mouse_up, Go up a workspace, workspace, e+1"
          "$mainMod, Comma, Go down a workspace, workspace, e-1"
          "$mainMod, mouse_down, Go down a workspace, workspace, e-1"
          "$mainMod, Tab, Go to previous workspace, workspace, previous"
          # Special workspace
          "$mainMod, F2, Toggles the Special workspace, togglespecialworkspace, special"
          "$mainMod SHIFT, F2, Move current window to Special workspace, movetoworkspace,special"
          "$mainMod, F1, Call special workspace scratchpad, togglespecialworkspace, scratchpad"
          "$mainMod SHIFT, F1, Move active window to special workspace scratchpad, movetoworkspacesilent, special:scratchpad"
        ]
        ++ workspaceBinds;

      binded = [
        # Brightness
        ", XF86MonBrightnessDown, Lowers the brightness, exec, brightnessctl set 5%-"
        ", XF86MonBrightnessUp, Raises the brightness, exec, brightnessctl set 5%+"
        # Volume
        ", XF86AudioMute, Mutes the sound output, exec, amixer set Master toggle"
        ", XF86AudioLowerVolume, Lowers the sound output, exec, amixer set Master 5%-"
        ", XF86AudioRaiseVolume, Raises the sound output, exec, amixer set Master 5%+"
      ];
      bindmd = [
        "$mainMod, mouse:272, Moves the window using the mouse, movewindow"
        "$mainMod, mouse:273, Resizes the window using the mouse, resizewindow"
      ];

      cursor = {
        no_hardware_cursors = true;
      };

      debug = {
        full_cm_proto = true;
      };

      dwindle = {
        pseudotile = false;
        preserve_split = true;
      };

      # Use default to merge
      env = lib.mkOptionDefault (
        [
          "LIBSEAT_BACKEND,logind"
          "NVD_BACKEND,direct"
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
          "QT_SCALE_FACTOR,1"
          "QT_QPA_PLATFORM,wayland;xcb"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        ]
        ++ lib.lists.optional config.modules.desktop.wayland.hyprland.autoDetectGPU "AQ_DRM_DEVICES,$HOME/.config/hypr/igpu:$HOME/.config/hypr/dgpu"
      );

      general = {
        border_size = 1;
        "col.active_border" = "rgba(ffffff88)";
        "col.inactive_border" = "rgba(00000000)";
        gaps_in = 3;
        gaps_out = 5;
        layout = "dwindle";
        resize_on_border = true;
        snap = {
          enabled = true;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_distance = 250;
        workspace_swipe_create_new = false;
      };

      input = {
        follow_mouse = 2;
        mouse_refocus = false;
        repeat_delay = 250;
        touchpad = {
          disable_while_typing = false;
          natural_scroll = false;
        };
      };

      misc = {
        enable_swallow = true;
        swallow_regex = "^(firefox|dolphin)";
        focus_on_activate = true;
        vfr = false; # Flickers on Nvidia
      };

      render = {
        direct_scanout = true;
      };

      windowrule = [
        # Floating windows
        "float, class:^()$,title:^(Save File)$"
        "float, class:^()$,title:^(Open File)$"
        "float, class:^(.blueman-manager-wrapped)$"
        "float, class:^(xdg-desktop-portal-gtk|xdg-desktop-portal-hyprland)(.*)$"
        "float, class:^(steam)$,title:^(Steam.+|Friends List)$" # Usually a floating window
        "float, title:^(Picture in picture)$"
        "float, title:^(Picture-in-Picture)$"
        "float, title:^(termfloat)$"
      ];

      workspace = [
        "special:scratchpad, on-created-empty:[float; move 50% 2%; size 50% 46%] $terminal"
      ];
    };
    extraConfig =
      let
        mkSubmap =
          name: submap:
          assert lib.assertMsg (name != "reset") "'reset' is not a valid submap";
          ''
            ${with submap.params; "bindd = ${mod}, ${key}, ${description}, submap, ${name}"}
            submap = ${name}

            ${lib.hm.generators.toHyprconf {
              attrs = submap.binds;
              indentLevel = 1;
            }}
            ${lib.optionalString (submap.params.catchallExit or false) "bind = , catchall, submap, reset"}
            submap = reset
          '';
        mkSubmaps = submaps: lib.concatStringsSep "\n" (lib.mapAttrsToList mkSubmap submaps);
      in
      mkSubmaps {
        resize = {
          params = {
            mod = "$mainMod";
            key = "R";
            description = "Submap for resizing windows";
          };
          binds = {
            binded = [
              ", M, Switch to the move submap, submap, move"
              ", left, Resize to the west (resizing mode), resizeactive, -20 0"
              ", H, Resize to the west (resizing mode), resizeactive, -20 0"
              ", down, Resize to the south (resizing mode), resizeactive, 0 20"
              ", J, Resize to the south (resizing mode), resizeactive, 0 20"
              ", up, Resize to the north (resizing mode), resizeactive, 0 -20"
              ", K, Resize to the north (resizing mode), resizeactive, 0 -20"
              ", right, Resize to the east (resizing mode), resizeactive, 20 0"
              ", L, Resize to the east (resizing mode), resizeactive, 20 0"
              ", Escape, Exit the submap, submap, reset"
            ];
          };
        };
        move = {
          params = {
            mod = "$mainMod SHIFT";
            key = "R";
            description = "Submap for moving windows";
          };
          binds = {
            binded = [
              ", R, Switch to resize submap, submap, resize"
              ", left, Move to the right (moving mode), moveactive, -25 0"
              ", H, Move to the right (moving mode), moveactive, -25 0"
              ", down, Move to the right (moving mode), moveactive, 0 25"
              ", J, Move to the right (moving mode), moveactive, 0 25"
              ", up, Move to the right (moving mode), moveactive, 0 -25"
              ", K, Move to the right (moving mode), moveactive, 0 -25"
              ", right, Move to the right (moving mode), moveactive, 25 0"
              ", L, Move to the right (moving mode), moveactive, 25 0"
              ", Escape, Exit the submap, submap, reset"
            ];
          };
        };
      };
  };
}
