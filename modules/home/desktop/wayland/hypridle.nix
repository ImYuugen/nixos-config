{ config, lib, ... }:

let
  cfg = config.modules.desktop.wayland.hypridle;
in
{
  options.modules.desktop.wayland.hypridle = {
    enable = lib.mkEnableOption "Hypridle";
  };

  config = lib.mkIf cfg.enable {
    services.hypridle = {
      enable = lib.mkDefault true;
      # Default config
      settings = {
        general = {
          lock_cmd = lib.mkDefault "pidof hyprlock || hyprlock";
          before_sleep_cmd = lib.mkDefault "loginctl lock-session";
          after_sleep_cmd = lib.mkDefault "hyprctl dispatch dpms on";
        };
        listener = lib.mkDefault [
          {
            timeout = 240;
            on-timeout = "hyprctl hyprsunset gamma -50";
            on-resume = "hyprctl hyprsunset gamma +50";
          }
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 600;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 1800;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
