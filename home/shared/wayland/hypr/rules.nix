{
  wayland.windowManager.hyprland.settings = {
    layerrule = [ ];
    windowrulev2 = [
      # Floating terminal
      "float, class:(termfloat)"
      "size 400 400, class:(termfloat)"
      "move cursor -50% -50%, class:(termfloat)"
      # Firefox PiP
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"
    ];
    windowrule = [
      # Match firefox versions
      "noblur, ^(firefox(-.*)?)$"
      "noblur, ^(librewolf(-.*)?)$"
    ];
    workspace = [
      # Smart gaps/No gaps when only
      "w[tv1], gapsout:0, gapsin:0, bordersize:0, rounding:0"
      "f[1], gapsout:0, gapsin:0, bordersize:0, rounding:0"
    ];
  };
}
