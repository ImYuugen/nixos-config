{ config, lib, ... }:

let
  cfg = config.modules.programs.cli.zoxide;
in
{
  options.modules.programs.cli.zoxide = {
    enable = lib.mkEnableOption "Zoxide";
  };

  config = lib.mkIf cfg.enable {
    programs.zoxide.enable = lib.mkDefault true;
  };
}
