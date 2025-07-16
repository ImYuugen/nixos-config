{
  config,
  lib,
  pkgsSet,
  ...
}:

let
  cfg = config.modules.programs.communications.discord;
in
{
  options.modules.programs.communications.discord = {
    enable = lib.mkEnableOption "Discord";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgsSet.unstable.legcord
    ];
  };
}
