{ config, lib, ... }:

let
  cfg = config.modules.programs.cli.fastfetch;
  # TODO: Add some presets
  # presets = {};
in
{
  options.modules.programs.cli.fastfetch = {
    enable = lib.mkEnableOption "Fastfetch";
    # preset = lib.mkOption { ... }
  };

  config = lib.mkIf cfg.enable {
    programs.fastfetch = {
      enable = lib.mkDefault true;
      # config = lib.mkIf (lib.mkDefault presets.${cfg.preset});
    };
  };
}
