{ config, lib, ... }:

let
  cfg = config.modules.networking.networkmanager;
in
{
  options.modules.networking.networkmanager = {
    enable = lib.mkEnableOption "Network Manager";
    iwd = lib.mkEnableOption "Iwd Backend";
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager = {
      enable = lib.mkDefault true;
      wifi = {
        backend = lib.mkIf cfg.iwd (lib.mkDefault "iwd");
      };
    };
  };
}
