{ config, lib, ... }:

let
  cfg = config.modules.programs.shells.cli.fzf;
in
{
  options.modules.programs.shells.cli.fzf = {
    enable = lib.mkEnableOption "Fuzzy Finder";
  };

  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = lib.mkDefault true;
    };
  };
}
