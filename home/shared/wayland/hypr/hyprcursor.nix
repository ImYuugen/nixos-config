{
  lib,
  pkgsSet,
  ...
}:
let
  cursor = {
    light = {
      name = "Bibata-Modern-Classic";
    };
    dark = {
      name = "Bibata-Modern-Ice";
    };
    package = pkgsSet.stable.bibata-cursors;
    size = 20;
  };
in
{
  home.pointerCursor = {
    inherit (cursor) package size;
    gtk.enable = true;
    name = "${cursor.light.name}";
    hyprcursor = {
      enable = true;
      size = cursor.size;
    };
  };

  # Doesn't work for GTK, because GTK
  services.darkman = {
    lightModeScripts.swapCursor = "hyprctl setcursor ${cursor.light.name} ${builtins.toString cursor.size}";
    darkModeScripts.swapCursor = "hyprctl setcursor ${cursor.dark.name} ${builtins.toString cursor.size}";
  };

  specialisation = {
    light.configuration = {
      home.pointerCursor = {
        name = lib.mkForce cursor.light.name;
      };
    };
    dark.configuration = {
      home.pointerCursor = {
        name = lib.mkForce cursor.dark.name;
      };
    };
  };
}
