{
  config,
  lib,
  pkgsSet,
  ...
}:

let
  cfg = config.modules.audio;
in
{
  options.modules.audio = {
    pipewire.enable = lib.mkEnableOption "Pipewire";
    withDefaultPackages = lib.mkEnableOption "With Default Packages";
  };

  config = {
    services.pipewire = lib.mkIf cfg.pipewire.enable {
      enable = lib.mkDefault true;
      alsa = {
        enable = lib.mkDefault true;
        support32Bit = lib.mkDefault true;
      };
      jack.enable = lib.mkDefault true;
      pulse.enable = lib.mkDefault true;
      wireplumber.enable = lib.mkDefault true;
    };

    environment.systemPackages = lib.mkIf cfg.withDefaultPackages (
      with pkgsSet.stable;
      [
        alsa-lib
        alsa-utils
        pavucontrol
      ]
    );
  };
}
