{ config, lib, ... }:

let
  cfg = config.modules.power.power-profiles-daemon;
in
{
  options.modules.power.power-profiles-daemon = {
    enable = lib.mkEnableOption "power-profiles-daemon";
  };

  config = lib.mkIf cfg.enable {
    services.power-profiles-daemon = {
      enable = lib.mkDefault true;
    };
  };
}
