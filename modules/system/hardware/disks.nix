{ config, lib, ... }:

let
  cfg = config.modules.hardware.disks;
in
{
  options.modules.hardware.disks = {
    enable = lib.mkEnableOption "Disk management";
  };

  config = lib.mkIf cfg.enable {
    services.udisks2.enable = lib.mkDefault true;
    programs.gnome-disks.enable = lib.mkDefault true;
  };
}
