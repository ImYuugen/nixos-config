{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.programs.media.spotify;
in
{
  options.modules.programs.media.spotify = {
    enable = lib.mkEnableOption "Spotify";
    daemon = lib.mkEnableOption "SpotifyD";
  };

  config = {
    home.packages = lib.mkIf cfg.enable [
      pkgs.spotify
    ];

    services.spotifyd = lib.mkIf cfg.daemon {
      enable = lib.mkDefault true;
    };
  };
}
