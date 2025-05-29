{ config, lib, ... }:

let
  cfg = config.modules.virtualisation.docker;
in
{
  options.modules.virtualisation.docker = {
    enable = lib.mkEnableOption "Docker";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = lib.mkDefault true;
      rootless.enable = lib.mkDefault true;
      enableOnBoot = lib.mkDefault false;
    };
  };
}
