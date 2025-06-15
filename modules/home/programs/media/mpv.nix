{ config, lib, ... }:

let
  cfg = config.modules.programs.media.mpv;
in
{

  options.modules.programs.media.mpv = {
    enable = lib.mkEnableOption "MPV";
  };

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = lib.mkDefault true;
      profiles = lib.mkDefault {
        fast = {
          vo = "vdpau";
        };
      };
    };
  };
}
