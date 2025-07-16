{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.gaming.dolphin-emu;
in
{
  options.modules.gaming.dolphin-emu = {
    enable = lib.mkEnableOption "Dolphin Emulator";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.dolphin-emu
    ];
  };
}
