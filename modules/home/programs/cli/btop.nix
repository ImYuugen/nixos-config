{ config, lib, ... }:

let
  cfg = config.modules.programs.cli.btop;
in
{
  options.modules.programs.cli.btop = {
    enable = lib.mkEnableOption "Btop";
  };

  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = lib.mkDefault true;
      settings = lib.mkDefault { };
    };
  };
}
