{ config, lib, ... }:

let
  cfg = config.modules.audio;
in
{
  options.modules.audio = {
    pipewire.enable = lib.mkEnableOption "Pipewire";
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
  };
}
