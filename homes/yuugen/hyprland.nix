{ lib, ... }:

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

    binds = {
      workspace_back_and_forth = true;
    };

    bind =
      [
        "$mainMod SHIFT, Q, killactive,"
        "$mainMod, Return, exec, $TERMINAL"
        "$mainMod, D, exec, rofi -show drun"
        "$mainMod SHIFT, D, exec, rofi -show run"
        "$mainMod, apostrophe, togglesplit,"
        "$mainMod, P, pseudo"
        "$mainMod, F, togglefloating"
        "$mainMod, M, fullscreen,"
        "$mainMod SHIFT, P, pin"
        # Windows
        "$mainMod, left, movefocus, l"
        "$mainMod, H, movefocus, l"
        "$mainMod, down, movefocus, l"
        "$mainMod, J, movefocus, l"
        "$mainMod, up, movefocus, l"
        "$mainMod, K, movefocus, l"
        "$mainMod, right, movefocus, l"
        "$mainMod, L, movefocus, l"
        # Move windows
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, down, movewindow, l"
        "$mainMod SHIFT, J, movewindow, l"
        "$mainMod SHIFT, up, movewindow, l"
        "$mainMod SHIFT, K, movewindow, l"
        "$mainMod SHIFT, right, movewindow, l"
        "$mainMod SHIFT, L, movewindow, l"
        # Apps
        "$appMod, W, exec, $BROWSER"
      ]
      # Workspaces
      ++ [
        "$mainMod, mouse_down, workspace, e-1"
        "$mainMod, mouse_up, workspace, e+1"
      ]
      ++ workspaceBinds;
    binde = [
      # Resize window
      "$mainMod ALT, left, resizeactive, -10 0"
      "$mainMod ALT, H, resizeactive, -10 0"
      "$mainMod ALT, down, resizeactive, 0 10"
      "$mainMod ALT, J, resizeactive, 0 10"
      "$mainMod ALT, up, resizeactive, 0 -10"
      "$mainMod ALT, K, resizeactive, 0 -10"
      "$mainMod ALT, right, resizeactive, 10 0"
      "$mainMod ALT, L, resizeactive, 10 0"
      # TODO: XF86
    ];
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    cursor = {
      no_hardware_cursors = true;
    };

    decoration = {
      rounding = 8;
    };

    dwindle = {
      pseudotile = false;
      preserve_split = true;
    };

    # Use default to merge
    env = lib.mkOptionDefault [
      "LIBSEAT_BACKEND,logind"
      "NVD_BACKEND,direct"
      "ELECTRON_OZONE_PLATFORM_HINT,auto"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_SCALE_FACTOR,1"
      "QT_QPA_PLATFORM,wayland;xcb"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
    ];

    general = {
      border_size = 1;
      "col.active_border" = "rgba(ffffff88)";
      "col.inactive_border" = "rgba(00000000)";
      gaps_in = 0;
      gaps_out = 4;
      layout = "dwindle";
      resize_on_border = true;
    };
  };
}
