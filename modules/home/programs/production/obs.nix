{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.programs.production.obs;
in
{
  options.modules.programs.production.obs = {
    enable = lib.mkEnableOption "OBS Studio";
  };

  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = lib.mkDefault true;
      plugins = lib.mkDefault (
        with pkgs.obs-studio-plugins;
        [
          advanced-scene-switcher
          input-overlay
          obs-multi-rtmp
          obs-pipewire-audio-capture
          obs-vaapi
        ]
      );
    };
  };
}
