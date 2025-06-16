{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.gaming.gamecube;
in
{
  options.modules.gaming.gamecube = {
    enable = lib.mkEnableOption "Use a gamecube controller the right way";
    overclockGCC = lib.mkEnableOption "Overclock your GCC to 1kHz";
  };

  config = lib.mkIf cfg.enable {
    boot = lib.mkIf cfg.overclockGCC {
      extraModulePackages = [
        config.boot.kernelPackages.gcadapter-oc-kmod
      ];
      kernelModules = [ "gcadapter_oc" ];
    };
    services.udev.packages = [ pkgs.dolphin-emu ];
  };
}
