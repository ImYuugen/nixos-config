{ inputs, pkgsSet, ... }:

let
  wallpapers = {
    light = ../../../../resources/wallpapers/light/kronii.jpg;
    dark = ../../../../resources/wallpapers/dark/cpunk2077.jpg;
  };
in
{
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgsSet.stable.system}.hyprpaper;
    settings = {
      preload = [ "${wallpapers.dark}" ];
      wallpaper = [ ",${wallpapers.dark}" ];
    };
  };

  services.darkman = {
    lightModeScripts.hyprpaper = ''
      hyprctl hyprpaper preload "${wallpapers.light}"
      hyprctl hyprpaper wallpaper ",${wallpapers.light}"
    '';
    darkModeScripts.hyprpaper = ''
      hyprctl hyprpaper preload "${wallpapers.dark}"
      hyprctl hyprpaper wallpaper ",${wallpapers.dark}"
    '';
  };
}
