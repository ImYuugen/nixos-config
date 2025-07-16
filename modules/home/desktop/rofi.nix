{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.desktop.rofi;
in
{
  options.modules.desktop.rofi = {
    enable = lib.mkEnableOption "Rofi";
  };

  config = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = lib.mkDefault true;
      package = lib.mkDefault pkgs.rofi-wayland;
    };
  };
}
