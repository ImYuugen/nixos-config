{ config, lib, ... }:

let
  cfg = config.modules.programs.shells.cli.zoxide;
in
{
  options.modules.programs.shells.cli.zoxide = {
    enable = lib.mkEnableOption "Zoxide";
  };

  config = lib.mkIf cfg.enable {
    programs.zoxide.enable = lib.mkDefault true;
  };
}
