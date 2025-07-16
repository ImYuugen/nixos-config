{ config, lib, ... }:

let
  cfg = config.modules.programs.direnv;
in
{
  options.modules.programs.direnv = {
    enable = lib.mkEnableOption "Direnv";
    withMise = lib.mkEnableOption "Mise";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = lib.mkDefault true;
      nix-direnv.enable = lib.mkDefault true;
      silent = lib.mkDefault true;
    };
  };
}
