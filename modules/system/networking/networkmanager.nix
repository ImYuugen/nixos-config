{ config, lib, ... }:

let
  cfg = config.modules.networking.networkmanager;
in
{
  options.modules.networking.networkmanager = {
    enable = lib.mkEnableOption "Network Manager";
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager = {
      enable = lib.mkDefault true;
      wifi = {
        backend = lib.mkDefault "iwd";
      };
    };
  };
}
