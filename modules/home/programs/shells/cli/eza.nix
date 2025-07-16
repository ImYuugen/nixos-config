{ config, lib, ... }:

let
  cfg = config.modules.programs.shells.cli.eza;
in
{
  options.modules.programs.shells.cli.eza = {
    enable = lib.mkEnableOption "Eza";
  };

  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = lib.mkDefault true;
      colors = lib.mkDefault "always";
      git = lib.mkDefault true;
      icons = lib.mkDefault "always";
      extraOptions = lib.mkDefault [
        "--group-directories-first"
        "--header"
      ];
    };
  };
}
