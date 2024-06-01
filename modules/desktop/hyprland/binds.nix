let
  workspaces = builtins.concatLists (builtins.genList (
    x:
    let
      ws =
        let
          c = (x + 1) / 10;
        in
        builtins.toString (x + 1 - (c * 10));
    in
    [
      "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
      "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      "$mainMod CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
    ]
  ) 10);
in
{
  wayland.windowManager.hyprland.settings = {
    binds = {
      workspace_back_and_forth = "true";
    };

    bind = [
      "$mainMod SHIFT, Q, killactive,"
      "$mainMod SHIFT CTRL ALT, R, exec, hyprctl reload"
      "$mainMod SHIFT, P, pin"
      "$mainMod SHIFT, x, exec, hyprlock"
      # Omen button
      ", XF86Launch2, exec, hyprlock"
      # Screenshots
      "$mainMod, Print, exec, grimblast --notify copy screen"
      "$mainMod SHIFT, S, exec, grimblast --notify copy area"
      "$mainMod SHIFT, Print, exec, grimblast --notify --freeze save area"
      # Term
      "$mainMod, Return, exec, kitty"
      "$mainMod SHIFT, Return, exec, kitty --class='termfloat'"
      # Launcher
      "$mainMod, D, exec, rofi -show drun"
      "$mainMod SHIFT, D, exec, rofi -show run"
      # Apps
      "$appMod, W, exec, firefox"
      # Layout
      "$mainMod, P, pseudo"
      "$mainMod, apostrophe, togglesplit,"
      "$mainMod, F, togglefloating,"
      "$mainMod, M, fullscreen,"
      # Workspaces
      "$mainMod, mouse_down, workspace, e-1"
      "$mainMod, mouse_up, workspace, e+1"
      # Focus windows
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"
      "$mainMod, H, movefocus, l"
      "$mainMod, L, movefocus, r"
      "$mainMod, K, movefocus, u"
      "$mainMod, J, movefocus, d"
      # Move windows
      "$mainMod SHIFT, left, movewindow, l"
      "$mainMod SHIFT, right, movewindow, r"
      "$mainMod SHIFT, up, movewindow, u"
      "$mainMod SHIFT, down, movewindow, d"
      "$mainMod SHIFT, H, movewindow, l"
      "$mainMod SHIFT, L, movewindow, r"
      "$mainMod SHIFT, K, movewindow, u"
      "$mainMod SHIFT, J, movewindow, d"
    ] ++ workspaces;
    binde = [
      # Resize window
      "$mainMod ALT, left, resizeactive, -10 0"
      "$mainMod ALT, right, resizeactive, 10 0"
      "$mainMod ALT, up, resizeactive, 0 -10"
      "$mainMod ALT, down, resizeactive, 0 10"
      "$mainMod ALT, H, resizeactive, -10 0"
      "$mainMod ALT, L, resizeactive, 10 0"
      "$mainMod ALT, K, resizeactive, 0 -10"
      "$mainMod ALT, J, resizeactive, 0 10"
      # Brightness
      ", XF86MonBrightnessDown, exec, light -U 5"
      ", XF86MonBrightnessUp, exec, light -A 5"
      # Volume
      ", XF86AudioMute, exec, amixer set Master toggle"
      ", XF86AudioLowerVolume, exec, amixer set Master 5%-"
      ", XF86AudioRaiseVolume, exec, amixer set Master 5%+"
      # Media controls
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
    ];
    bindl = [ ];
  };
}
