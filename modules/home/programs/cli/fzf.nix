{ config, lib, ... }:

let
  cfg = config.modules.programs.cli.fzf;
in
{
  options.modules.programs.cli.fzf = {
    enable = lib.mkEnableOption "Fuzzy Finder";
  };

  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = lib.mkDefault true;
    };
  };
}
