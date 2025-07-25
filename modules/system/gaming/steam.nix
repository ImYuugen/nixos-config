{
  config,
  lib,
  pkgs,
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
      package = pkgs.steam.override {
        extraPkgs = (
          spkgs: with spkgs; [
            gamemode
          ]
        );
      };
      extraCompatPackages = lib.mkIf cfg.withProtonGE (lib.mkDefault [ pkgs.proton-ge-bin ]);
      remotePlay.openFirewall = lib.mkDefault true;
      dedicatedServer.openFirewall = lib.mkDefault true;
      extest.enable = lib.mkDefault true;
      gamescopeSession = lib.mkIf cfg.withGamescopeSession {
        enable = lib.mkDefault true;
        steamArgs = lib.mkDefault [
          "-gamepadui"
          "-steamdeck"
        ];
        args = lib.mkDefault [
          "--expose-wayland"
        ];
      };
    };
    environment.systemPackages =
      let
        gamescopeDesktop = pkgs.makeDesktopItem {
          name = "steam-gamescope";
          desktopName = "Steam Gamescope";
          exec = "steam-gamescope %U";
          icon = "steam";
          terminal = false;
          categories = [
            "Game"
          ];
          prefersNonDefaultGPU = true;
        };
      in
      [ gamescopeDesktop ];
  };
}
