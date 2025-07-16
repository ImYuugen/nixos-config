{ config, lib, ... }:

let
  cfg = config.modules.programs.shells.cli.bat;
in
{
  options.modules.programs.shells.cli.bat = {
    enable = lib.mkEnableOption "Bat";
  };

  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = lib.mkDefault true;
    };
  };
}
