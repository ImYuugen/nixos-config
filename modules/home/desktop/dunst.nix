{
  config,
  lib,
  ...
}:

let
  cfg = config.modules.desktop.dunst;
in
{
  options.modules.desktop.dunst = {
    enable = lib.mkEnableOption "Dunst";
  };

  config = lib.mkIf cfg.enable {
    services.dunst = {
      enable = lib.mkDefault true;
      settings = lib.mkDefault {
        global = {
          width = 300;
          height = 300;
          offset = "30x50";
          origin = "top-right";
          transparency = 10;
          frame_color = "#eceff1";
          font = "Droid Sans 9";
        };

        urgency_normal = {
          background = "#37474f";
          foreground = "#eceff1";
          timeout = 10;
        };
      };
    };
  };
}
