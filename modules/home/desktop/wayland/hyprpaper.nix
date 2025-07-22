{ config, lib, ... }:

let
  cfg = config.modules.desktop.wayland.hyprpaper;
in
{
  options.modules.desktop.wayland.hyprpaper = {
    enable = lib.mkEnableOption "Hyprpaper";
  };

  config = lib.mkIf cfg.enable {
    services.hyprpaper = {
      enable = lib.mkDefault true;
    };
    wayland.windowManager.hyprland.settings.exec-once = [
      "hyprpaper"
    ];
  };
}
