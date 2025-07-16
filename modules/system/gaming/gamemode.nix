{
  config,
  lib,
  ...
}:

let
  cfg = config.modules.gaming.gamemode;
in
{
  options.modules.gaming.gamemode = {
    enable = lib.mkEnableOption "Gamemode";
  };

  config = lib.mkIf cfg.enable {
    programs.gamemode = {
      enable = lib.mkDefault true;
      settings = lib.mkDefault {
        custom = {
          # Just assume libnotify is there, worst case scenario ? Nothing happens
          start = "notify-send 'Gamemode started _(:3 」∠)_'";
          end = "notify-send 'Gamemode ended [(－－)]..zzZ'";
        };
      };
    };
  };
}
