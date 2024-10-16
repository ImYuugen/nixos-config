{ inputs, pkgsSet, ... }:
let
  wallpaper = ./resources/115738312_p0.jpg;
in
{
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgsSet.stable.system}.hyprpaper;
    settings = {
      preload = [ "${wallpaper}" ];
      wallpaper = [ ", ${wallpaper}" ];
    };
  };
}
