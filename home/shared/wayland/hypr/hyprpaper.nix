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
  };

  specialisation = {
    light.configuration.services.hyprpaper.settings = {
      preload = [ "${wallpapers.light}" ];
      wallpaper = [ ",${wallpapers.light}" ];
    };
    dark.configuration.services.hyprpaper.settings = {
      preload = [ "${wallpapers.dark}" ];
      wallpaper = [ ",${wallpapers.dark}" ];
    };
  };

  services.darkman =
    let
      paperScript = wallpaper: ''
        timeout=40
        socket_path="/run/user/1000/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.hyprpaper.sock"
        echo "Looking for $socket_path"
        until [ -S "$socket_path" ]; do
          timeout=$((timeout - 1))
          if [ $timeout -eq 0 ]; then
            echo "Timed out" >&2
            break
          fi
          printf "X | "
          sleep 0.25
        done

        if [ $timeout -ne 0 ]; then
          echo "O"
          hyprctl hyprpaper preload "${wallpaper}"
          hyprctl hyprpaper wallpaper ",${wallpaper}"
        fi
      '';
    in
    {
      lightModeScripts.hyprpaper = paperScript wallpapers.light;
      darkModeScripts.hyprpaper = paperScript wallpapers.dark;
    };
}
