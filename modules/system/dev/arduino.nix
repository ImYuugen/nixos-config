{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.dev.arduino;
in
{
  options.modules.dev.arduino = {
    enable = lib.mkEnableOption "Arduino";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      arduino
      arduino-cli
      arduino-ide
    ];
  };
}
