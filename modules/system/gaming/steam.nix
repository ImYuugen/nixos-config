{
  config,
  lib,
  pkgsSet,
  ...
}:

let
  cfg = config.modules.gaming.steam;
in
{
  options.modules.gaming.steam = {
    enable = lib.mkEnableOption "Steam";
    withProtonGE = lib.mkEnableOption "Proton GE";
    withGamescopeSession = lib.mkEnableOption "Gamescope Session";
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = lib.mkDefault true;
      extraCompatPackages = lib.mkIf cfg.withProtonGE (lib.mkDefault [ pkgsSet.stable.proton-ge-bin ]);
      remotePlay.openFirewall = lib.mkDefault true;
      dedicatedServer.openFirewall = lib.mkDefault true;
      extest.enable = lib.mkDefault true;
      gamescopeSession = lib.mkIf cfg.withGamescopeSession {
        enable = lib.mkDefault true;
      };
    };
  };
}
