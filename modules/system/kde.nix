{ config, lib, ... }:

let
  cfg = config.modules.kde;
in
{
  options.modules.kde = {
    enable = lib.mkEnableOption "KDE Plasma";
  };

  config = lib.mkIf cfg.enable {
    services.desktopManager.plasma6 = {
      enable = lib.mkDefault true;
    };
  };
}
