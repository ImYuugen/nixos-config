{ inputs, pkgsSet, ... }:
rec {
  home.packages = [
    inputs.hyprcursor
    pkgsSet.stable.hyprcursor
  ];
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgsSet.stable.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 20;
  };
  wayland.windowManager.hyprland.settings.exec-once = [
    "hyprctl setcursor ${home.pointerCursor.name} ${toString home.pointerCursor.size}"
  ];
}
