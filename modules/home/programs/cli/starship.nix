{ config, lib, ... }:

let
  cfg = config.modules.programs.cli.starship;
in
{
  options.modules.programs.cli.starship = {
    enable = lib.mkEnableOption "Starship";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = lib.mkDefault true;
      settings = lib.mkDefault {
        add_newline = false;
      };
    };
  };
}
