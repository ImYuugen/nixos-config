{ config, lib, ... }:

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
      in
      [
        "$mainMod, ${ws}, workspace, ${builtins.toString (x + 1)}"
        "$mainMod SHIFT, ${ws}, movetoworkspace, ${builtins.toString (x + 1)}"
        "$mainMod CTRL, ${ws}, movetoworkspacesilent, ${builtins.toString (x + 1)}"
      ]
    ) 10
  );
in
{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$appMod" = "ALT SHIFT";

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

    bind =
      [
        "$mainMod SHIFT, Q, killactive,"
        "$mainMod, Return, exec, $TERMINAL"
        "$mainMod, D, exec, rofi -show drun"
        "$mainMod SHIFT, D, exec, rofi -show run"
        "$mainMod SHIFT, X, exec, hyprlock"
        "$mainMod SHIFT, XF86Launch2, exec, hyprlock"
        # Screenshots
        "$mainMod, Print, exec, grimblast --notify copy screen"
        "$mainMod SHIFT, S, exec, grimblast --notify copy area"
        "$mainMod SHIFT, Print, exec, grimblast --notify --freeze save area"
        # Layout
        "$mainMod, apostrophe, togglesplit,"
        "$mainMod, P, pseudo"
        "$mainMod, F, togglefloating"
        "$mainMod, M, fullscreen,"
        "$mainMod SHIFT, P, pin"
        # Windows
        "$mainMod, left, movefocus, l"
        "$mainMod, H, movefocus, l"
        "$mainMod, down, movefocus, d"
        "$mainMod, J, movefocus, d"
        "$mainMod, up, movefocus, u"
        "$mainMod, K, movefocus, u"
        "$mainMod, right, movefocus, r"
        "$mainMod, L, movefocus, r"
        # Move windows
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, down, movewindow, d"
        "$mainMod SHIFT, J, movewindow, d"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, L, movewindow, r"
        # Apps
        "$appMod, W, exec, $BROWSER"
        # Media controls
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
      ]
      # Workspaces
      ++ [
        "$mainMod, mouse_down, workspace, e-1"
        "$mainMod, mouse_up, workspace, e+1"
      ]
      ++ workspaceBinds;
    binde = [
      # Resize window
      "$mainMod ALT, left, resizeactive, -20 0"
      "$mainMod ALT, H, resizeactive, -20 0"
      "$mainMod ALT, down, resizeactive, 0 20"
      "$mainMod ALT, J, resizeactive, 0 20"
      "$mainMod ALT, up, resizeactive, 0 -20"
      "$mainMod ALT, K, resizeactive, 0 -20"
      "$mainMod ALT, right, resizeactive, 20 0"
      "$mainMod ALT, L, resizeactive, 20 0"
      # Move floating window
      "$mainMod CTRL ALT, left, moveactive, -25 0"
      "$mainMod CTRL ALT, H, moveactive, -25 0"
      "$mainMod CTRL ALT, down, moveactive, 0 25"
      "$mainMod CTRL ALT, J, moveactive, 0 25"
      "$mainMod CTRL ALT, up, moveactive, 0 -25"
      "$mainMod CTRL ALT, K, moveactive, 0 -25"
      "$mainMod CTRL ALT, right, moveactive, 25 0"
      "$mainMod CTRL ALT, L, moveactive, 25 0"
      # Brightness
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      # Volume
      ", XF86AudioMute, exec, amixer set Master toggle"
      ", XF86AudioLowerVolume, exec, amixer set Master 5%-"
      ", XF86AudioRaiseVolume, exec, amixer set Master 5%+"
    ];
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
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
      gaps_in = 0;
      gaps_out = 4;
      layout = "dwindle";
      resize_on_border = true;
    };

    input = {
      follow_mouse = 2;
      mouse_refocus = false;
      touchpad.natural_scroll = false;
      repeat_delay = 250;
    };
  };
}
