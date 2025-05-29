{ config, lib, ... }:

let
  cfg = config.modules.power.powerManagement;
in
{
  options.modules.power.powerManagement = {
    enable = lib.mkEnableOption "Power Management";
  };

  config = lib.mkIf cfg.enable {
    powerManagement = {
      enable = lib.mkDefault true;
      powertop.enable = lib.mkDefault true;
    };
  };
}
