{ config, lib, ... }:
{
  boot = lib.mkIf config.services.tlp.enable {

  };
}
