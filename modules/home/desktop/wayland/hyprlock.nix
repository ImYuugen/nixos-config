{ config, lib, ... }:

let
  cfg = config.modules.desktop.wayland.hyprlock;
in
{
  options.modules.desktop.wayland.hyprlock = {
    enable = lib.mkEnableOption "Hyprlock";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = lib.mkDefault true;
      # Default config
      settings = {
        general = {
          disable_loading_bar = lib.mkDefault true;
          hide_cursor = lib.mkDefault false;
          grace = lib.mkDefault 1;
        };
        background = {
          path = lib.mkDefault "screenshot";
          blur_passes = lib.mkDefault 3;
          blur_size = lib.mkDefault 5;
          brightness = lib.mkDefault 0.75;
          noise = lib.mkDefault 5.0e-2;
        };
        input-field = lib.mkDefault [
          {
            monitor = lib.mkDefault "";
            size = lib.mkDefault "20%, 5%";
            outline_thickness = lib.mkDefault 3;
            dots_center = lib.mkDefault true;
            dots_size = lib.mkDefault 0.33;
            dots_spacing = lib.mkDefault 0.15;
            placeholder_text = lib.mkDefault ''<i>Pass</i>'';
            fail_text = lib.mkDefault "$PAMFAIL";
            hide_input = lib.mkDefault false;
            position = lib.mkDefault "0, 200";
            halign = lib.mkDefault "center";
            valign = lib.mkDefault "bottom";
          }
        ];
        label = lib.mkDefault [
          {
            monitor = "";
            text = "cmd[update:60000] date +\"%A, %d %B %Y\"";
            font_size = 50;
            position = "0, 25%";
            valign = "center";
            halign = "center";
          }
          {
            monitor = "";
            text = "$TIME";
            font_size = 75;
            position = "0, 10%";
            valign = "center";
            halign = "center";
          }
        ];
      };
    };
  };
}
