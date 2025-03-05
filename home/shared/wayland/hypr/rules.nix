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
      "noblur, ^(firefox(-*)?)$"
      "noblur, ^(librewolf(-*)?)$"
    ];
  };
}
