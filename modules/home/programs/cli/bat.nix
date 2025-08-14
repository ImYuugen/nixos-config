{ config, lib, ... }:

let
  cfg = config.modules.programs.cli.bat;
in
{
  options.modules.programs.cli.bat = {
    enable = lib.mkEnableOption "Bat";
  };

  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = lib.mkDefault true;
    };
  };
}
