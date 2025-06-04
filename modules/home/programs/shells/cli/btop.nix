{ config, lib, ... }:

let
  cfg = config.modules.programs.shells.cli.btop;
in
{
  options.modules.programs.shells.cli.btop = {
    enable = lib.mkEnableOption "Btop";
  };

  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = lib.mkDefault true;
      settings = lib.mkDefault { };
    };
  };
}
