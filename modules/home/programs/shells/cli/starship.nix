{ config, lib, ... }:

let
  cfg = config.modules.programs.shells.cli.starship;
in
{
  options.modules.programs.shells.cli.starship = {
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
